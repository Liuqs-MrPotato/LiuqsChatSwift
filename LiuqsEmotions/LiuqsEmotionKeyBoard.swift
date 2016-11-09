//
//  LiuqsEmotionKeyBoard.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/15.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

public protocol LiuqsEmotionKeyBoardDelegate {
    
    func emotionView_sBtnDidClick(btn:UIButton)
    
    func gifBtnClick(btn:UIButton)
}

class LiuqsEmotionKeyBoard: UIImageView ,UIScrollViewDelegate {
    
    //公有属性
    var sendBtn:UIButton       = UIButton()
    
    var emojiBtn:UIButton      = UIButton()

    var delegate:LiuqsEmotionKeyBoardDelegate?
    
    //私有固定常量
    private let rows:Int = 3
    
    private let pages:Int = 7
    
    private let rowCount:Int = 7
    
    private let gifCount:Int = 18
    
    private let emojicount:Int = 21
    
    private let gifRowCount:Int = 4
    
    private let emotionBtnsCount:Int = 2
    
    private let gifW:CGFloat = screenW * 0.15625
    
    private let gifH:CGFloat = screenW * 0.22
    
    private let emotionW:CGFloat = screenW * 0.0875
    
    //对照表
    private var _emotionGifTitle:NSDictionary   = NSDictionary()
    
    private var _emojiStaticImages:NSDictionary = NSDictionary()
    
    private var _emojiTags:NSArray = NSArray()
    
    
    //私有属性和控件
    private var font:UIFont  = UIFont()
    
    private var gap: CGFloat = 0.0
    
    private var EMOJI_MAX_SIZE:CGFloat = 0.0
    
    private var btnsBar:UIButton      = UIButton()
    
    private var springBtn:UIButton    = UIButton()
    
    private var emotionBtn:UIButton   = UIButton()
    
    private var pageView:UIScrollView = UIScrollView()
    
    private var scrollBtnsView:UIScrollView      = UIScrollView()
    
    private var pageControl:       UIPageControl = UIPageControl()
    
    private var emotonViewPageOne:   UIImageView = UIImageView()
    
    private var emotonViewPageTwo:   UIImageView = UIImageView()
    
    private var emotonViewPageThree: UIImageView = UIImageView()
    
    private var emotonViewPageFour:  UIImageView = UIImageView()
    
    private var emotonViewPageFive:  UIImageView = UIImageView()
    
    private var emotonViewPageSix:   UIImageView = UIImageView()
    
    private var emotonViewPageSeven: UIImageView = UIImageView()
    
    private var emotonViewPageEight: UIImageView = UIImageView()
    
    var KeyTextView:UITextView? {
    
        didSet {setSomeProperty()}
    }
    
    func setSomeProperty() {
    
        if (KeyTextView!.font == nil) {
            
            KeyTextView?.font = UIFont.systemFont(ofSize: 17)
        }
        font = (KeyTextView?.font!)!
        
        EMOJI_MAX_SIZE = heightWithFont(font: font)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.backgroundColor = UIColor.white
        
        initEmojiDatas()
        
        createScorllView()
        
        createEmotionViews()
        
        createPageControl()
        
        creatPageViewOneBtns()
        
        ceartPageViewTwoBtns()
        
        ceartPageViewFourBtns()
        
        ceartPageViewThreeBtns()
        
        creatGifBtns()
        
        creatBottomBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("初始化失败")
    }
    
    
    func initEmojiDatas() {
    
        sendBtn.isEnabled = false
        
        self.isUserInteractionEnabled = true
        
        gap = (screenW - (CGFloat(rowCount) * emotionW)) / (CGFloat(rowCount) + 1)
        
        let staPath:String = Bundle.main.path(forResource: "LiuqsEmoji", ofType: "plist")!
        
        let gifPath:String = Bundle.main.path(forResource: "LiuqsGifEmoji", ofType: "plist")!
        
        let tagPath:String = Bundle.main.path(forResource: "LiuqsEmotionTags", ofType: "plist")!
        
        _emojiTags         = NSArray.init(contentsOfFile: tagPath)!
        
        _emotionGifTitle   = NSDictionary.init(contentsOfFile: gifPath)!
        
        _emojiStaticImages = NSDictionary.init(contentsOfFile: staPath)!

    }
    
    func createScorllView() {
        
        let frame:CGRect = CGRect.init(x: 0, y: 0, width: screenW, height: (CGFloat(rows) * emotionW + CGFloat(rows + 1) * self.gap))
    
        let pageView:UIScrollView = UIScrollView.init(frame: frame)
        
        pageView.backgroundColor = UIColor.clear
        
        pageView.bounces = false
        
        pageView.isPagingEnabled = true
        
        pageView.showsVerticalScrollIndicator = false
        
        pageView.showsHorizontalScrollIndicator = false
        
        pageView.contentSize = CGSize.init(width: screenW * CGFloat(pages), height: 0)
        
        pageView.delaysContentTouches = true
        
        pageView.delegate = self
        
        self.pageView = pageView
        
        self.addSubview(pageView)
        
    }
    
    func createEmotionViews() {
        
        for i:Int in 0..<pages {
            
            let frame:CGRect = CGRect.init(x: CGFloat(i) * screenW, y: 0, width: screenW, height: pageView.frame.size.height)
            
            let emotionPageView:UIImageView = UIImageView.init(frame: frame)
            
            pageView.addSubview(emotionPageView)
            
            emotionPageView.backgroundColor = UIColor.clear
            
            emotionPageView.isUserInteractionEnabled = true
            if (i == 0) {
                self.emotonViewPageOne   = emotionPageView
            }else if (i == 1)
            {
                self.emotonViewPageTwo   = emotionPageView
            }else if (i == 2)
            {
                self.emotonViewPageThree = emotionPageView
                
            }else if (i == 3)
            {
                self.emotonViewPageFour  = emotionPageView
            }else if (i == 4)
            {
                self.emotonViewPageFive  = emotionPageView
                
            }else if (i == 5)
            {
                self.emotonViewPageSix   = emotionPageView
            }else if (i == 6)
            {
                self.emotonViewPageSeven = emotionPageView
            }else if (i == 7)
            {
                self.emotonViewPageEight = emotionPageView
            }
        }
    }
    
    func creatPageViewOneBtns() {
    
        var row:Int = 1
        
        let space:CGFloat = CGFloat(screenW - CGFloat(rowCount) * emotionW) / CGFloat(rowCount + 1)
        
        for i:Int in 0..<emojicount {
          
            row = i / rowCount + 1
            
            let btn:UIButton = UIButton()
            
            let Xu:CGFloat = (CGFloat(1 + i) - (CGFloat(rowCount) * CGFloat(row - 1))) * space
            
            let Xd:CGFloat = CGFloat(i - (rowCount * (row - 1))) * emotionW
            
            btn.frame = CGRect.init(x: Xu + Xd, y: space * CGFloat(row) + CGFloat(row - 1) * emotionW, width: emotionW, height: emotionW)
            
            btn.tag = i + 1
            
            if (i == emojicount - 1) {
                
                btn.tag = 211;
                
                btn.setImage(UIImage.init(named: "backDelete"), for: UIControlState.normal)
                
                btn.frame.size = CGSize.init(width: emotionW + space, height: emotionW + space)
                
                let X:CGFloat = btn.frame.origin.x;
                
                let Y:CGFloat = btn.frame.origin.y;
                
                btn.frame = CGRect.init(x: X - space / 3, y: btn.frame.origin.y, width: btn.frame.size.width, height: btn.frame.size.height)
                
                btn.frame = CGRect.init(x: btn.frame.origin.x, y: Y - space / 3, width: btn.frame.size.width, height: btn.frame.size.height)
                
                btn.addTarget(self, action: #selector(self.deleteBtnClick(btn:)), for: UIControlEvents.touchUpInside)

            }else {
                
                let imageName = "[" + String(btn.tag) + "]"
                
                btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
                
                btn.addTarget(self, action: #selector(self.insertEmoji(btn:)), for: UIControlEvents.touchUpInside)
            }
            
            self.emotonViewPageOne.addSubview(btn)
        }
    }
    
    func ceartPageViewTwoBtns() {
        
        var row:Int = 1
        
        let space:CGFloat = CGFloat(screenW - CGFloat(rowCount) * emotionW) / CGFloat(rowCount + 1)
        
        for i:Int in 0..<emojicount {
            
            row = i / rowCount + 1
            
            let btn:UIButton = UIButton()
            
            let Xu:CGFloat = (CGFloat(1 + i) - (CGFloat(rowCount) * CGFloat(row - 1))) * space
            
            let Xd:CGFloat = CGFloat(i - (rowCount * (row - 1))) * emotionW
            
            btn.frame = CGRect.init(x: Xu + Xd, y: space * CGFloat(row) + CGFloat(row - 1) * emotionW, width: emotionW, height: emotionW)
            
            btn.tag = i + 21
            
            if (i == emojicount - 1) {
                
                btn.tag = 212;
                
                btn.setImage(UIImage.init(named: "backDelete"), for: UIControlState.normal)
                
                btn.frame.size = CGSize.init(width: emotionW + space, height: emotionW + space)
                
                let X:CGFloat = btn.frame.origin.x;
                
                let Y:CGFloat = btn.frame.origin.y;
                
                btn.frame = CGRect.init(x: X - space / 3, y: btn.frame.origin.y, width: btn.frame.size.width, height: btn.frame.size.height)
                
                btn.frame = CGRect.init(x: btn.frame.origin.x, y: Y - space / 3, width: btn.frame.size.width, height: btn.frame.size.height)
                
                btn.addTarget(self, action: #selector(self.deleteBtnClick(btn:)), for: UIControlEvents.touchUpInside)
                
            }else {
                
                
                let imageName = "[" + String(btn.tag) + "]"
                
                btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
                
                btn.addTarget(self, action: #selector(self.insertEmoji(btn:)), for: UIControlEvents.touchUpInside)
            }
            
            self.emotonViewPageTwo.addSubview(btn)
        }
    }
    
    func ceartPageViewThreeBtns() {
        
        var row:Int = 1
        
        let space:CGFloat = CGFloat(screenW - CGFloat(rowCount) * emotionW) / CGFloat(rowCount + 1)
        
        for i:Int in 0..<emojicount {
            
            row = i / rowCount + 1
            
            let btn:UIButton = UIButton()
            
            let Xu:CGFloat = (CGFloat(1 + i) - (CGFloat(rowCount) * CGFloat(row - 1))) * space
            
            let Xd:CGFloat = CGFloat(i - (rowCount * (row - 1))) * emotionW
            
            btn.frame = CGRect.init(x: Xu + Xd, y: space * CGFloat(row) + CGFloat(row - 1) * emotionW, width: emotionW, height: emotionW)
            
            btn.tag = i + 41
            
            if (i == emojicount - 1) {
                
                btn.tag = 213;
                
                btn.setImage(UIImage.init(named: "backDelete"), for: UIControlState.normal)
                
                btn.frame.size = CGSize.init(width: emotionW + space, height: emotionW + space)
                
                let X:CGFloat = btn.frame.origin.x;
                
                let Y:CGFloat = btn.frame.origin.y;
                
                btn.frame = CGRect.init(x: X - space / 3, y: btn.frame.origin.y, width: btn.frame.size.width, height: btn.frame.size.height)
                
                btn.frame = CGRect.init(x: btn.frame.origin.x, y: Y - space / 3, width: btn.frame.size.width, height: btn.frame.size.height)
                
                btn.addTarget(self, action: #selector(self.deleteBtnClick(btn:)), for: UIControlEvents.touchUpInside)
                
            }else {
                
                let imageName = "[" + String(btn.tag) + "]"
                
                btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
                
                btn.addTarget(self, action: #selector(self.insertEmoji(btn:)), for: UIControlEvents.touchUpInside)
            }
            
            self.emotonViewPageThree.addSubview(btn)
        }
    }
    
    func ceartPageViewFourBtns() {
        
        var row:Int = 1
        
        let space:CGFloat = CGFloat(screenW - CGFloat(rowCount) * emotionW) / CGFloat(rowCount + 1)
        
        for i:Int in 0..<emojicount {
            
            row = i / rowCount + 1
            
            let btn:UIButton = UIButton()
            
            let Xu:CGFloat = (CGFloat(1 + i) - (CGFloat(rowCount) * CGFloat(row - 1))) * space
            
            let Xd:CGFloat = CGFloat(i - (rowCount * (row - 1))) * emotionW
            
            btn.frame = CGRect.init(x: Xu + Xd, y: space * CGFloat(row) + CGFloat(row - 1) * emotionW, width: emotionW, height: emotionW)
            
            btn.tag = i + 61
            
            if (i == emojicount - 1) {
                
                btn.tag = 214;
                
                btn.setImage(UIImage.init(named: "backDelete"), for: UIControlState.normal)
                
                btn.frame.size = CGSize.init(width: emotionW + space, height: emotionW + space)
                
                let X:CGFloat = btn.frame.origin.x;
                
                let Y:CGFloat = btn.frame.origin.y;
                
                btn.frame = CGRect.init(x: X - space / 3, y: btn.frame.origin.y, width: btn.frame.size.width, height: btn.frame.size.height)
                
                btn.frame = CGRect.init(x: btn.frame.origin.x, y: Y - space / 3, width: btn.frame.size.width, height: btn.frame.size.height)
                
                btn.addTarget(self, action: #selector(self.deleteBtnClick(btn:)), for: UIControlEvents.touchUpInside)
                
            }else {
                
                
                let imageName = "[" + String(btn.tag) + "]"
                
                btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
                
                btn.addTarget(self, action: #selector(self.insertEmoji(btn:)), for: UIControlEvents.touchUpInside)
                
            }
            
            if (i >= 12) {
                btn.isUserInteractionEnabled = false;
            }
            
            self.emotonViewPageFour.addSubview(btn)
        }
    }

    //动态图按钮
    
    func creatGifBtns() {
    
        let Vgap:CGFloat = (self.emotonViewPageSeven.frame.size.height - gifH * 2) / 2
        
        let Lgap:CGFloat = (screenW - gifW * CGFloat(gifRowCount)) / 5
        
        var row:CGFloat
        
        var page:CGFloat
        
        for i:Int in 0..<gifCount {
            
            row = CGFloat(i / 4 + 1)
            
            page = CGFloat(i / 8)
            
            let btn:UIButton = UIButton.init(frame: CGRect.init(x: CGFloat(1.0 + CGFloat(i) - (CGFloat(gifRowCount) * CGFloat(row - 1))) * Lgap + (CGFloat(i) - (CGFloat(gifRowCount) * CGFloat(row - 1))) * gifW, y: Vgap * row + CGFloat(row - 1) * gifH + 2 - page * self.emotonViewPageSix.frame.size.height, width: gifW, height: gifH))
            
            btn.tag = i + 1
            
            let titleLabel:UILabel = UILabel.init(frame: CGRect.init(x: 0, y: gifW, width: gifW, height: gifH - gifW))

            titleLabel.textColor = UIColor.gray

            titleLabel.textAlignment = NSTextAlignment.center
            
            titleLabel.font = UIFont.systemFont(ofSize: 11)
            
            let imageKey:String = String(btn.tag)
            
            let title:String = String(describing: _emotionGifTitle[imageKey]!)
            
            titleLabel.text = title
            
            btn.addSubview(titleLabel)
            
            let imageView:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: gifW, height: gifW))
            
            let gifName = "2_" + String(btn.tag) + ".gif"
            
            imageView.setImage(UIImage.init(named: gifName), for: UIControlState.normal)
            
            imageView.tag = i + 1
            
            imageView.addTarget(self, action: #selector(self.emotionGifClick(btn:)), for: UIControlEvents.touchUpInside)
            
            btn.addSubview(imageView)
            
            if (i >= 0 && i < 8) {
                
                self.emotonViewPageFive.addSubview(btn)
            }else if (i >= 8 && i < 16)
            {
                self.emotonViewPageSix.addSubview(btn)
            }else if (i >= 16 && i < 24)
            {
                self.emotonViewPageSeven.addSubview(btn)
            }else if (i >= 20 && i < 32)
            {
                self.emotonViewPageEight.addSubview(btn)
            }
        }
    }
    
    func createPageControl() {
    
        let pagecontrol:UIPageControl = UIPageControl.init(frame: CGRect.init(x: 0, y: self.emotonViewPageOne.frame.size.height, width: screenW, height: 15))
        
        pagecontrol.numberOfPages = 4
        
        pagecontrol.currentPage = 0
        
        pagecontrol.pageIndicatorTintColor = UIColor.lightGray
        
        pagecontrol.currentPageIndicatorTintColor = UIColor.orange
        
        pagecontrol.hidesForSinglePage = false
        
        pagecontrol.backgroundColor = UIColor.clear
        
        self.pageControl = pagecontrol
        
        self.addSubview(pagecontrol)
    }
    
    func creatBottomBar() {
    
        cteateBottomBtnBar()
        
        createSendBtn()
        
        createEmotionBtns()
        
    }
    
    func cteateBottomBtnBar() {
        
        let line:UIView = UIView.init(frame: CGRect.init(x: 0, y: self.emotonViewPageOne.frame.size.height + 15, width: screenW, height: 1))
        
        line.backgroundColor = BACKGROUND_Color
        
        self.addSubview(line)
        
        let btnsBar:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: self.emotonViewPageOne.frame.size.height + 16, width: screenW, height: emotionW + 5))
        
        self.btnsBar = btnsBar
        
        btnsBar.isUserInteractionEnabled = true
        
        btnsBar.backgroundColor = UIColor.white
        
        self.addSubview(btnsBar)
        
    }
    
    func createSendBtn() {
        
        let sendBtn:UIButton = UIButton.init(frame: CGRect.init(x: screenW * 6 / 7, y: 0, width: screenW / 7, height: btnsBar.frame.size.height))
        
        sendBtn.setTitle("发送", for: UIControlState.normal)
        
        sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        sendBtn.setBackgroundImage(UIImage.createImageWithColor(color: BLUE_Color), for: UIControlState.selected)
        
        sendBtn.setBackgroundImage(UIImage.createImageWithColor(color: UIColor.lightGray), for: UIControlState.normal)
        
        sendBtn.isSelected = true
        
        sendBtn.tag = 44
        
        sendBtn.addTarget(self, action:  #selector(emotionBtnDidClick(btn:)), for: UIControlEvents.touchUpInside)
    
        btnsBar.addSubview(sendBtn)
        
    }
    
    func createEmotionBtns() {
    
        for i:Int in 0..<emotionBtnsCount {
        
            let emotionBtn:UIButton = UIButton.init(frame: CGRect.init(x: CGFloat(i) * screenW / 7, y: 0, width: screenW / 7, height: btnsBar.frame.size.height))
            
            emotionBtn.tag = i
            
            emotionBtn.backgroundColor = UIColor.white
            
            emotionBtn.addTarget(self, action: #selector(emotionBtnsClick(btn:)), for: UIControlEvents.touchUpInside)
            
            btnsBar.addSubview(emotionBtn)
            
            emotionBtn.setImage(UIImage.init(named: "compose_emoticonbutton_background"), for: UIControlState.normal)
            
            emotionBtn.setImage(UIImage.init(named: "compose_emoticonbutton_background_highlighted"), for: UIControlState.selected)
            
            emotionBtn.setBackgroundImage(UIImage.createImageWithColor(color: BACKGROUND_Color), for: UIControlState.selected)
            
            if (i == 0) {
                emotionBtn.isSelected = true;
                
                self.emotionBtn = emotionBtn;
                
                self.emojiBtn = emotionBtn;
                
            }else if (i == 1) {
                
                self.springBtn = emotionBtn;
            }
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (self.emojiBtn.isSelected) {
            
            self.pageControl.numberOfPages = 4
            
            self.pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5)
            
        }else if (self.springBtn.isSelected)
        {
            //处理pagecontrol
            self.pageControl.numberOfPages = 3
            
            let totle = (self.pageView.contentOffset.x - screenW * 4)
            
            self.pageControl.currentPage = Int(totle / screenW + 0.5)
        }else{}
        if (screenW * 4 <= scrollView.contentOffset.x + screenW / 2) {
            
            self.emotionBtn.isSelected = false
            
            self.emotionBtn = self.springBtn
            
            self.springBtn.isSelected = !self.springBtn.isSelected
            
        }else if (scrollView.contentOffset.x < screenW * 4 - screenW / 2)
        {
            self.emotionBtn.isSelected = false
            
            self.emotionBtn = self.emojiBtn
            
            self.emojiBtn.isSelected = !self.emojiBtn.isSelected
        }

    
    }
    
    func heightWithFont(font:UIFont)->CGFloat {
        
        let dict = [NSFontAttributeName:font]
        
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        
        let text: NSString = "/"
        
        let rect:CGRect = text.boundingRect(with: CGSize.init(width: 100, height: 1000), options: option, attributes: dict, context: nil)
        
        return rect.size.height
    }
    
    func deleteBtnClick(btn:UIButton) {
        
        self.KeyTextView?.deleteBackward()
        
        emotionBtnDidClick(btn: btn)
    }
    
    //静态表情的按钮事件
    func insertEmoji(btn:UIButton) {
    
        emotionBtnDidClick(btn: btn)
        
        let emojiTextAttachment:LiuqsTextAttachment = LiuqsTextAttachment()
        
        emojiTextAttachment.emojiTag = _emojiTags[btn.tag - 1] as! String
        
        let imageName:String = _emojiStaticImages.object(forKey: emojiTextAttachment.emojiTag)! as! String
        
        emojiTextAttachment.image = UIImage.init(named: imageName)
        
        emojiTextAttachment.emojiSize = CGSize.init(width: EMOJI_MAX_SIZE, height: EMOJI_MAX_SIZE);
        
        let attstr:NSAttributedString = NSAttributedString.init(attachment: emojiTextAttachment)
        
        KeyTextView?.textStorage.insert(attstr, at: (KeyTextView?.selectedRange.location)!)
        
        KeyTextView?.selectedRange = NSRange.init(location: (KeyTextView?.selectedRange.location)! + 1, length: (KeyTextView?.selectedRange.length)!)
        
        emotionBtnDidClick(btn: btn)
        
        resetTextStyle()
        
    }
    
    func resetTextStyle() {
    
        let wholeRange:NSRange = NSRange.init(location: 0, length: (KeyTextView?.textStorage.length)!)
        
        KeyTextView?.textStorage.removeAttribute(NSFontAttributeName, range: wholeRange)
        
        KeyTextView?.textStorage.addAttributes([NSFontAttributeName:font], range: wholeRange)
        
        KeyTextView?.scrollRectToVisible(CGRect.init(x: 0, y: 0, width: (KeyTextView?.contentSize.width)!, height: (KeyTextView?.contentSize.height)!), animated: true)
        
    }
    
    //gif表情按钮点击事件
    func emotionGifClick(btn:UIButton) {
    
        self.delegate?.gifBtnClick(btn: btn)
    }
    
    //发送，删除，表情等按钮的事件，用来处理按钮状态
    func emotionBtnDidClick(btn:UIButton) {
    
        self.delegate?.emotionView_sBtnDidClick(btn: btn)
        
    }
    
    //底部按钮条上的表情按钮，切换不同类型表情
    func emotionBtnsClick(btn:UIButton) {
        
        self.emotionBtn.isSelected = false;
        
        self.emotionBtn = btn;
        
        btn.isSelected = !btn.isSelected;
        
        if (btn.tag == 0) {
            
            var point:CGPoint = self.pageView.contentOffset;
            
            point.x = 0;
            
            UIView.animate(withDuration: 0, animations: {
                
                self.pageView.contentOffset = point;
            })
            
        }else if (btn.tag == 1) {
            
            var point:CGPoint = self.pageView.contentOffset;
            
            point.x = screenW * 4;
            
            UIView.animate(withDuration: 0, animations: {
               
                self.pageView.contentOffset = point;
            })
        }

    }
    
}



















