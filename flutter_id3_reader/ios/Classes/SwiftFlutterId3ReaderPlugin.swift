import Flutter
import UIKit

public class SwiftFlutterAudioQueryPlugin: NSObject, FlutterPlugin {

  let CHANNEL_NAME:String = "com.pehlivanov.zlati.flutter_id3_reader.methods";
  let m_delegate = FlutterId3ReaderDelegate();

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: CHANNEL_NAME, binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAudioQueryPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let arguments = call.arguments as? [String: Any]
    switch (call.method){
      case  "getTag"
        m_delegate.songSourceHandler(call, result);

      case  "getSongs"
        m_delegate.songSourceHandler(call, result);

      case  "getAlbumArt"
        m_delegate.artworkSourceHandler(call, result);
        
      default:
            result(FlutterMethodNotImplemented)
    }

  }
}

