import Foundation
@preconcurrency import AVFoundation
import Vision

@Observable
@MainActor
final class PoseDetectionService: NSObject {
    private(set) var detectedJoints: [String: CGPoint] = [:]
    private(set) var isDetecting = false
    private(set) var confidence: Float = 0

    private let captureSession = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    private let processingQueue = DispatchQueue(label: "com.jojostrike.pose", qos: .userInteractive)

    var session: AVCaptureSession { captureSession }

    func startSession() async {
        guard !isDetecting else { return }

        let authorized = await checkAuthorization()
        guard authorized else { return }

        captureSession.beginConfiguration()
        captureSession.sessionPreset = .high

        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: camera),
              captureSession.canAddInput(input) else {
            captureSession.commitConfiguration()
            return
        }

        captureSession.addInput(input)

        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.setSampleBufferDelegate(self, queue: processingQueue)

        guard captureSession.canAddOutput(videoOutput) else {
            captureSession.commitConfiguration()
            return
        }

        captureSession.addOutput(videoOutput)

        if let connection = videoOutput.connection(with: .video) {
            connection.videoRotationAngle = 0
        }

        captureSession.commitConfiguration()

        let session = captureSession
        processingQueue.async {
            session.startRunning()
        }
        isDetecting = true
    }

    func stopSession() {
        let session = captureSession
        processingQueue.async {
            session.stopRunning()
        }
        isDetecting = false
        detectedJoints = [:]
    }

    private func checkAuthorization() async -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return true
        case .notDetermined:
            return await AVCaptureDevice.requestAccess(for: .video)
        default:
            return false
        }
    }

    nonisolated private func processBodyPose(from sampleBuffer: CMSampleBuffer) {
        let request = VNDetectHumanBodyPoseRequest()
        let handler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up)

        do {
            try handler.perform([request])
            guard let observation = request.results?.first else {
                Task { @MainActor in
                    self.detectedJoints = [:]
                    self.confidence = 0
                }
                return
            }

            let jointMapping: [(String, VNHumanBodyPoseObservation.JointName)] = [
                ("nose", .nose),
                ("neck", .neck),
                ("leftShoulder", .leftShoulder),
                ("rightShoulder", .rightShoulder),
                ("leftElbow", .leftElbow),
                ("rightElbow", .rightElbow),
                ("leftWrist", .leftWrist),
                ("rightWrist", .rightWrist),
                ("leftHip", .leftHip),
                ("rightHip", .rightHip),
                ("leftKnee", .leftKnee),
                ("rightKnee", .rightKnee),
                ("leftAnkle", .leftAnkle),
                ("rightAnkle", .rightAnkle),
            ]

            var joints: [String: CGPoint] = [:]
            var totalConfidence: Float = 0
            var count: Float = 0

            for (name, jointName) in jointMapping {
                if let point = try? observation.recognizedPoint(jointName), point.confidence > 0.3 {
                    joints[name] = CGPoint(x: point.location.x, y: 1 - point.location.y)
                    totalConfidence += point.confidence
                    count += 1
                }
            }

            let avgConfidence = count > 0 ? totalConfidence / count : 0

            Task { @MainActor in
                self.detectedJoints = joints
                self.confidence = avgConfidence
            }
        } catch {
            // Silently skip frame on error
        }
    }
}

extension PoseDetectionService: AVCaptureVideoDataOutputSampleBufferDelegate {
    nonisolated func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        processBodyPose(from: sampleBuffer)
    }
}
