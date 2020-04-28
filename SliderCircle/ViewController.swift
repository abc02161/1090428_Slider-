import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    //@IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var cupidImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var shootImageView: UIImageView!
    @IBOutlet weak var loveImageView: UIImageView!
    
    
    // 1度
    let oneDegree = CGFloat.pi / 180
    
    // 圓半徑
    let r: CGFloat = 275
    
    // 愛心縮放比例
    var loveScale: CGFloat = 1.5
    
    
    // 更新位置
    func updateLocation(degrees: CGFloat) {
        
        // 從原始位置(圓中心)identity 先 rotated旋轉 再 transkateBy移動 (順序要對！！！不然會原地旋轉)
        shootImageView.transform = CGAffineTransform.identity.rotated(by: degrees * oneDegree).translatedBy(x: r, y: 0)
        
        // 射到愛心後 愛心開始掉落
        if degrees > 271 {
            loveImageView.transform = CGAffineTransform.identity.rotated(by: degrees * oneDegree).translatedBy(x: r, y: 0).scaledBy(x: loveScale, y: loveScale)
            
            // 縮放愛心製造跳動效果
            if loveScale == 1.5{
                loveScale = 1
            } else {
                loveScale = 1.5
            }
            
        }

        // 顯示目前角度
        label.text = "\(Int(degrees))"
        
    }
    
    // Slider 滑動
    @IBAction func sliderChange(_ sender: UISlider) {
        updateLocation(degrees: CGFloat(sender.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 箭 初始位置於 211 度
        updateLocation(degrees: 211)
        
        // 邱比特 初始位置於 200 度
        cupidImageView.transform = CGAffineTransform.identity.rotated(by: 200 * oneDegree).translatedBy(x: 268, y: 0)
        
        // 愛心 初始位置於 270 度
        loveImageView.transform = CGAffineTransform.identity.rotated(by: 270 * oneDegree).translatedBy(x: 268, y: 0)
        
        
        // 先產生 SKView 物件
        let skView = SKView(frame: view.frame)
        // 將 skView 加入 view 底層當背景
        view.insertSubview(skView, at: 0)
        
        // SKView 顯示的內容由 SKScene 控制，因此我們產生 SKScene，然後從 skView 呼叫 presentScene 顯示 SKScene 的內容。
        let scene = SKScene(size: skView.frame.size)
        // 控制 scene 內容呈現的位置(型別是 CGPoint)，畫面的左下角為 (0, 0)，右上角為 (1, 1)
        scene.anchorPoint = CGPoint(x: 0.5, y: 1)
        // 背景設為白色
        scene.backgroundColor = .white
        
        // 粒子效果設定
        let emitterNode = SKEmitterNode(fileNamed: "magic")
        // 場景加入設定的粒子效果
        scene.addChild(emitterNode!)
        
        // 顯示 SKScene 內容
        skView.presentScene(scene)
    }
        
}
    

