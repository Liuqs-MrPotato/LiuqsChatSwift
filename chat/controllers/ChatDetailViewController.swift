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
    
    var dataSource:NSMutableArray = NSMutableArray()
    
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
    
        ScrollTableViewToBottom()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        self.view.addSubview(self.emotionview)
        
        self.emotionview.KeyTextView = self.toolBarView.textView;
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createExampleData()
        
        initSomething()
    
        addObsevers()
        
        creatToolBarView()
        
        initChatTableView()
    }
    
    func createExampleData() {
    
        for i: Int in 0...100 {
        
            let chatCellFrame:LiuqsChatCellFrame = LiuqsChatCellFrame()
            
            let message:LiuqsChatMessage = LiuqsChatMessage()
            
            if i % 2 == 0
            
            {message.currentUserType = userType.other}
            
            chatCellFrame.message = message
            
            dataSource.add(chatCellFrame)
        }
        
    }

    // 初始化一些数据
    func initSomething() {
        
        self.view.backgroundColor = BACKGROUND_Color
        
        self.automaticallyAdjustsScrollViewInsets = false
    
    }
    
    //创建tabbleView
    func initChatTableView() {
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: screenW, height: toolBarView.y - 64))
        
        tableView.backgroundColor = BACKGROUND_Color
        
        tableView.showsVerticalScrollIndicator = false
        
//        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        tableView.register(LiuqsChatMessageCell.self, forCellReuseIdentifier: "LiuqsChatMessageCell")
        
        self.view.addSubview(tableView)
        
        //单击手势,用于退出键盘
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapTable))
        
        tap.delegate = self
        
        tableView.addGestureRecognizer(tap)
    }
    
    //手势事件
    func tapTable() {
    
        if toolBarView.textView.isFirstResponder {
            
            toolBarView.textView.resignFirstResponder()
        }
    
        toolBarView.toolBarEmotionBtn.isSelected = false
        
        if toolBarView.textView.text.characters.count == 0 {
        
            UIView.animate(withDuration: emotionTipTime, animations: { 
                
                self.emotionview.frame = emotionDownFrame
                
                self.toolBarView.frame = toolBarFrameDown
                
                self.resetChatList()
            })
        }else {
            
            UIView.animate(withDuration: emotionTipTime, animations: {
            
                self.emotionview.frame = emotionDownFrame
                
                self.toolBarView.frame = CGRect.init(x: 0, y: screenH - self.toolBarView.frame.size.height, width: screenW, height: self.toolBarView.frame.size.height)
            
            })
            
            self.resetChatList()
        }
    }

    //注册监听
    func addObsevers() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(noti:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //键盘高度改变的通知事件
    func keyboardWillChangeFrame(noti:NSNotification) {
        
        let userInfo:NSDictionary = noti.userInfo!
        
        let keyBoardFrame:CGRect = (userInfo.object(forKey: UIKeyboardFrameEndUserInfoKey)?.cgRectValue)!
        
        let ketBoardY:CGFloat = keyBoardFrame.origin.y
        
        if ketBoardY == screenH {
            
            HandleKeyBoardHide()
        }else {
            
            HandleKeyBoardShow(keyBoardFrame: keyBoardFrame)
        }
        
        self.keyBoardH = keyBoardFrame.size.height;
    }
    
    //键盘隐藏的通知事件
    func keyboardWillHide(noti:NSNotification) {
        
        self.keyBoardH = 0;
        
        HandleKeyBoardHide()
    }

    
    //处理键盘弹出
    func HandleKeyBoardShow(keyBoardFrame:CGRect) {
     
        //键盘弹出
        UIView.animate(withDuration: emotionTipTime, animations: {
            
            self.toolBarView.toolBarEmotionBtn.isSelected = false
            
            self.toolBarView.frame = CGRect.init(x: 0, y: screenH - self.toolBarView.height - keyBoardFrame.size.height, width: screenW, height: self.toolBarView.height)
            
            self.emotionview.frame = emotionUpFrame
            
            self.resetChatList()
            
        })
        
        self.ScrollTableViewToBottom()
    }
    
    //处理键盘收起
    func HandleKeyBoardHide() {
        
        //键盘收起
        self.toolBarView.toolBarEmotionBtn.isSelected = true
        
        UIView.animate(withDuration: emotionTipTime, animations: {
            
            self.toolBarView.frame = CGRect.init(x: 0, y: screenH - self.toolBarView.height - self.emotionview.height, width: screenW, height: self.toolBarView.height)
            
            self.resetChatList()
        })
        
        
    }
    
    //创建工具条
    func creatToolBarView() {
    
        toolBarView.delegate = self
        
        toolBarView.textView.delegate = self
        
        self.view.addSubview(toolBarView)
        
    }
    
    //tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = LiuqsChatMessageCell.cellWithTableView(tableView: tableView)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let chatCellFrame:LiuqsChatCellFrame = dataSource.object(at: indexPath.row) as! LiuqsChatCellFrame
        
        cell.chatCellFrame = chatCellFrame
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.pushViewController(ChatDetailViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let chatCellFrame:LiuqsChatCellFrame = dataSource.object(at: indexPath.row) as! LiuqsChatCellFrame
        
        return chatCellFrame.cellHeight;
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        tapTable()
    }
    
    //toolBar代理
    func ToolbarEmotionBtnDidClicked(emotionBtn: UIButton) {
        
        if emotionBtn.isSelected {
        
            emotionBtn.isSelected = false;
            
            toolBarView.textView.becomeFirstResponder()
            
            resetChatList()
            
        }else {
        
            toolBarView.textView.resignFirstResponder()
            
            emotionBtn.isSelected = true
            
            UIView.animate(withDuration: emotionTipTime, animations: { 
                
                self.emotionview.frame = emotionUpFrame
                
                self.toolBarView.frame = CGRect.init(x: 0, y: screenH - self.toolBarView.height - self.emotionview.height, width: screenW, height: self.toolBarView.height)
                
                self.resetChatList()
            })
            
            self.ScrollTableViewToBottom()
        }
    }
    
    func resetChatList() {
    
       self.tableView.frame = CGRect.init(x: 0, y: self.tableView.y, width: screenW, height: self.toolBarView.y - 64)
    }
    
    //滚动到底部
    func ScrollTableViewToBottom() {
        
        let indexPath:NSIndexPath = NSIndexPath.init(row: self.dataSource.count - 1, section: 0)
        
        self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
    }

    //textView代理事件
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
        
        self.tableView.height = self.toolBarView.y - 64
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
