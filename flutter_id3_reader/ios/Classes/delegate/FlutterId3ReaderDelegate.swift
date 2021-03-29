import Foundation
import MediaPlayer

@available(iOS 9.3, *)
public class FlutterId3ReaderDelegate: FlutterId3ReaderDelegateProtocol {
  private let ERROR_CODE_PENDING_RESULT = "pending_result";
  private let ERROR_CODE_PERMISSION_DENIED = "PERMISSION DENIED";
  private let SORT_TYPE = "sort_type";
  private let PLAYLIST_METHOD_TYPE = "method_type";

  private var m_pendingCall: FlutterMethodCall?;
  private var m_pendingResult: FlutterResult?;
  
  private var avaibale: Bool = false

  private var  m_songLoader: SongLoader;
  private var  m_imageLoader: ImageLoader;

  init(){
    m_songLoader = SongLoader()
    m_imageLoader = ImageLoader()
  }

  public func songSourceHandler(_ call: FlutterMethodCall, _ result: FlutterResult){
    let arguments = call.arguments as? [String: Any]
    switch(call.method) {
      case "getTag"
        // m_songLoader.getSongs(result, SongSortType.init(rawValue: arguments![SORT_TYPE] as! Int)!)
      case "getSongs"
        print("getSongs: \(arguments ?? ["args": "no args"])")
        m_songLoader.getSongs(result, SongSortType.init(rawValue: arguments![SORT_TYPE] as! Int)!)
      default
        m_songLoader.getSongs(result, SongSortType.init(rawValue: arguments![SORT_TYPE] as! Int)!)

    }
  }

  public func imageSourceHandler(_ call: FlutterMethodCall, _ result: FlutterResult){
    let arguments = call.arguments as? [String: Any]
    let mediaId = arguments!["mediaId"] as! String
    let width = arguments!["width"] as? Int
    let height = arguments!["height"] as? Int
    let type = arguments!["resource"] as? Int
    m_imageLoader.getArtworkBytes(result, id, Double(width ?? 256), Double(height ?? 256))
    print("getArtwork: \(arguments ?? ["args": "no args"])")
  }
}

protocol AudioQueryDelegateProtocol{

    /**
     * Interface method to handle album queries related calls
     * @param call
     * @param result
     */
    func imageSourceHandler(_ call: FlutterMethodCall, _ result: FlutterResult);

    /**
     * Interface method to handle song queries related calls
     * @param call
     * @param result
     */
    func songSourceHandler(_ call: FlutterMethodCall, _ result: FlutterResult);

}