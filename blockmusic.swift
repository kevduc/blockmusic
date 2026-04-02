import AppKit

// Apps to block by bundle ID
let blockedIDs: Set<String> = ["com.apple.iTunes", "com.apple.Music"]

func terminateIfBlocklisted(_ app: NSRunningApplication) {
    guard let id = app.bundleIdentifier, blockedIDs.contains(id) else { return }
    app.forceTerminate()
}

// Terminate any blocklisted apps already running
NSWorkspace.shared.runningApplications.forEach(terminateIfBlocklisted)

// Watch for any app launch, terminate if it's blocklisted
NSWorkspace.shared.notificationCenter.addObserver(
    forName: NSWorkspace.willLaunchApplicationNotification, object: nil, queue: .main
) {
    notification in
    guard let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication else { return }
    terminateIfBlocklisted(app)
}

// Keep the process alive to receive notifications
RunLoop.main.run()
