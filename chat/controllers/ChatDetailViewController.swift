//
//  ChatDetailViewController.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/8.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class ChatDetailViewController: UIViewController ,LiuqsToolBarDelegate ,UITextViewDelegate ,UITableViewDelegate,UITableViewDataSource , UIGestureRecognizerDelegate , LiuqsEmotionKeyBoardDelegate{
    
    var toolBarView:LiuqsToolBarView = LiuqsToolBarView.init(frame: CGRect())
    
    var keyBoardH:CGFloat = CGFloat()
    
    var tableView:UITableView = UITableView()
    
    lazy private var emotionview:LiuqsEmotionKeyBoard = {
        
        let emotionview = LiuqsEmotionKeyBoard.init(frame: CGRect.init(x: 0, y: screenH, width: screenW, height: EMOJI_KEYBOARD_HEIGHT))
        
        emotionview.delegate = self
        
        return emotionview
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(true)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initSomething()
    
        addObsevers()
        
        initChatTableView()
        
        creatToolBarView()
        
        createEmotionView()
    }

    func initSomething() {
        
        self.view.backgroundColor = BACKGROUND_Color
        
        self.automaticallyAdjustsScrollViewInsets = false
    
    }
    
    //tabbleView
    func initChatTableView() {
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: screenW, height: screenH - 64 - self.toolBarView.frame.size.height))
        
//        tableView.backgroundColor = BACKGROUND_Color
        
        tableView.backgroundColor = UIColor.orange
        
        tableView.showsVerticalScrollIndicator = false
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        
        //单击手势,用于退出键盘
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapTable))
        
        tap.delegate = self
        
        tableView.addGestureRecognizer(tap)
    }
    
    func tapTable() {
    
        if toolBarView.textView.isFirstResponder {
            
            toolBarView.textView.resignFirstResponder()
        }
    
        toolBarView.toolBarEmotionBtn.isSelected = false
        
        if toolBarView.textView.text.characters.count == 0 {
        
            UIView.animate(withDuration: emotionTipTime, animations: { 
                
                self.emotionview.frame = emotionDownFrame
                
                self.toolBarView.frame = toolBarFrameDown
            })
        }else {
        
            self.emotionview.frame = emotionDownFrame
            
            self.toolBarView.frame = CGRect.init(x: 0, y: screenH - self.toolBarView.frame.size.height, width: screenW, height: self.toolBarView.frame.size.height)
        }
        
        UIView.animate(withDuration: emotionTipTime, animations: {
        
            self.tableView.height = screenH - self.toolBarView.height - 64
        })
        
    }

    //注册监听
    func addObsevers() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(noti:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //键盘高度改变
    func keyboardWillChangeFrame(noti:NSNotification) {
        
        let userInfo:NSDictionary = noti.userInfo!
        
        let keyBoardFrame:CGRect = (userInfo.object(forKey: UIKeyboardFrameEndUserInfoKey)?.cgRectValue)!
        
        let height:CGFloat = keyBoardFrame.origin.y + keyBoardFrame.size.height
        
        if height > screenH {
            
            self.toolBarView.toolBarEmotionBtn.isSelected = true
            
            UIView.animate(withDuration: emotionTipTime, animations: {
            
                self.toolBarView.frame = CGRect.init(x: 0, y: screenH - self.toolBarView.frame.size.height - self.emotionview.frame.size.height, width: screenW, height: self.toolBarView.frame.size.height)
            })
        }else {
            
            UIView.animate(withDuration: emotionTipTime, animations: {
                
                self.toolBarView.frame = CGRect.init(x: 0, y: screenH - self.toolBarView.frame.size.height - keyBoardFrame.size.height, width: screenW, height: self.toolBarView.frame.size.height)
            })
        }
        self.keyBoardH = keyBoardFrame.size.height;
    }
    //键盘隐藏
    func keyboardWillHide(noti:NSNotification) {
        
        self.keyBoardH = 0;
    }

    func creatToolBarView() {
    
        toolBarView.delegate = self
        
        toolBarView.textView.delegate = self
        
        self.view.addSubview(toolBarView)
        
    }
    
    func createEmotionView() {
        
        let deadlineTime = DispatchTime.now() + .milliseconds(5)
        
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            self.view.addSubview(self.emotionview)
            
            self.emotionview.KeyTextView = self.toolBarView.textView;
        }
    }
    
    //tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ChatListViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.pushViewController(ChatDetailViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.separatorInset = UIEdgeInsets.zero;
    }

    
    //toolBar代理
    func ToolbarEmotionBtnDidClicked(emotionBtn: UIButton) {
        
        if emotionBtn.isSelected {
        
            emotionBtn.isSelected = false;
            
            toolBarView.textView.becomeFirstResponder()
            
            self.tableView.height = screenH - self.keyBoardH - self.toolBarView.height - 64
            
        }else {
        
            toolBarView.textView.resignFirstResponder()
            
            emotionBtn.isSelected = true
            
            UIView.animate(withDuration: emotionTipTime, animations: { 
                
                self.emotionview.frame = emotionUpFrame
                
                self.toolBarView.frame = CGRect.init(x: 0, y: screenH - self.toolBarView.frame.size.height - self.emotionview.frame.size.height, width: screenW, height: self.toolBarView.frame.size.height)
                
                self.tableView.height = screenH - self.emotionview.height - self.toolBarView.height - 64
                
                if (self.tableView.contentSize.height > self.tableView.height) {
                    
                    self.tableView.setContentOffset(CGPoint.init(x: 0, y: self.tableView.contentSize.height - self.tableView.bounds.size.height + 3), animated: false)
                }
            })
        }
    }
    
    
  //textView代理
    
    func textViewDidBeginEditing(_ textView: UITextView) {
     
        self.toolBarView.toolBarEmotionBtn.isSelected = false
        
        UIView.animate(withDuration: emotionTipTime, animations: {
            
            self.tableView.height = screenH - self.keyBoardH - self.toolBarView.height - 64
            
            self.emotionview.frame = emotionUpFrame
            
            if (self.tableView.contentSize.height > self.tableView.height) {
                
                self.tableView.setContentOffset(CGPoint.init(x: 0, y: self.tableView.contentSize.height - self.tableView.bounds.size.height + 3), animated: false)
            }
        })
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if (self.toolBarView.textView.contentSize.height <= TextViewH) {
            
            self.toolBarView.textView.height = TextViewH;
            
        }else if (self.toolBarView.textView.contentSize.height >= 90) {
            
            self.toolBarView.textView.height = 90;
        }else {
            
            self.toolBarView.textView.height = self.toolBarView.textView.contentSize.height;
        }
        self.toolBarView.height = screenW * 10 / 320 + self.toolBarView.textView.height;
        
        
        if (self.keyBoardH < self.emotionview.height) {
            
            self.toolBarView.y = screenH - self.toolBarView.height - self.emotionview.height;
            
        }else {
            
            self.toolBarView.y = screenH - self.toolBarView.height - self.keyBoardH;
        }
        if (textView.text.characters.count > 0) {
            
            self.emotionview.sendBtn.isSelected = true;
            
        }else {
            
            self.emotionview.sendBtn.isSelected = false;
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        return true;
    }
    
    //keyBoard代理
    func emotionView_sBtnDidClick(btn:UIButton) {
    
       textViewDidChange(toolBarView.textView)
        
    }
    
    func gifBtnClick(btn:UIButton) {
    
        
    }
    
    
    
    
    
    
}
