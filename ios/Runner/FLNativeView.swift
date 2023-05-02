import Flutter
import UIKit
import UniformTypeIdentifiers

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger
    private let channel: FlutterMethodChannel

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        self.channel = FlutterMethodChannel(
            name: "samples.flutter.dev/clipboard",
            binaryMessenger: messenger
        )
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger,
            flutterChannel: channel
        )
    }
}

class FLNativeView: NSObject, FlutterPlatformView, UIPasteConfigurationSupporting {
    var pasteConfiguration: UIPasteConfiguration?
    
    private var _view: UIView
    private weak var label: UILabel?
    private let flutterChannel: FlutterMethodChannel
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?,
        flutterChannel: FlutterMethodChannel
    ) {
        _view = UIView()
        self.flutterChannel = flutterChannel
        super.init()
        // iOS views can be created here
        createNativeView(view: _view)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView){
        let nativeLabel = UILabel()
        nativeLabel.text = "pasted text will go here"
        nativeLabel.textAlignment = .center
        nativeLabel.numberOfLines = 0
        nativeLabel.frame = CGRect(x: 0, y: 0, width: 330, height: 160.0)
        nativeLabel.backgroundColor = .yellow.withAlphaComponent(0.2)
        _view.addSubview(nativeLabel)
        label = nativeLabel
        
        if #available(iOS 16.0, *) {
            let configuration = UIPasteControl.Configuration()
            configuration.cornerStyle = .capsule
            configuration.displayMode = .iconAndLabel

            let pasteControl = UIPasteControl(configuration: configuration)
            pasteControl.frame = CGRect(x: 0, y: nativeLabel.frame.height + 10, width: 330, height: 48.0)
            pasteControl.target = self
            _view.addSubview(pasteControl)
        }
    }
    
    func paste(itemProviders: [NSItemProvider]) {
        print("junge junge … paste(itemProviders:)")
        print(itemProviders)
        
        readClipbaordText(itemProviders: itemProviders) { clipboardText in
            DispatchQueue.main.async {
                self.label?.text = clipboardText
                self.flutterChannel.invokeMethod("pasteFromClipboard", arguments: clipboardText)
            }
        }
    }
    
    private func readClipbaordText(itemProviders: [NSItemProvider], completion: @escaping (String?) -> Void) {
        if let prov = itemProviders.first {
            if #available(iOS 16.0, *) {
                prov.loadItem(forTypeIdentifier: UTType.plainText.identifier) { data, error in
                    if let pasteboardFileUrl = data as? URL {
                        if let pasteboardFileContent = try? String(contentsOf: pasteboardFileUrl) {
                            completion(pasteboardFileContent)
                        }
                    }
                }
            }
        }
        completion(nil)
    }
    
    func canPaste(_ itemProviders: [NSItemProvider]) -> Bool {
        for prov in itemProviders {
            if prov.canLoadObject(ofClass: String.self) {
        return true
    }
        }
        return false
    }
    
}
