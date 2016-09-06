//
//  ChatDetailViewController.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/8.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class ChatDetailViewController: UIViewController ,LiuqsToolBarDelegate ,UITextViewDelegate ,UITableViewDelegate,UITableViewDataSource, LiuqsEmotionKeyBoardDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate{
    
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
        
        self.navigationController?.delegate = self
        
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
        
        for i: Int in 0...1 {
        
            let chatCellFrame:LiuqsChatCellFrame = LiuqsChatCellFrame()
            
            let message:LiuqsChatMessage = LiuqsChatMessage()
            
            var messageText = String()
            
            if i % 2 == 0 {
                
                message.currentUserType = userType.other
                message.userName = "鸣人"
                messageText = "在村里，Lz辈分比较大，在我还是小屁孩的时候就有大人喊我叔了，这不算糗。 成年之后，鼓起勇气向村花二丫深情表白了(当然是没有血缘关系的)，结果她一脸淡定的回绝了:“二叔！别闹……”"
            }else {
            
                message.userName = "路飞"
                messageText = "小学六年级书法课后不知是哪个用红纸写了张六畜兴旺贴教室门上，上课语文老师看看门走了，过了一会才来，过了几天去办公室交作业听见语文老师说：看见那几个字我本来是不想进去的，但是后来一想养猪的也得进去喂猪"
            }
            
            message.message = messageText
            
            chatCellFrame.message = message
            
            dataSource.add(chatCellFrame)
        }
    }

    // 初始化一些数据
    func initSomething() {
        
        self.view.backgroundColor = BACKGROUND_Color
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.title = "路飞"
    
    }
    
    //创建tabbleView
    func initChatTableView() {
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: toolBarView.y))
        
        tableView.backgroundColor = BACKGROUND_Color
        
        tableView.showsVerticalScrollIndicator = false
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
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
                
                self.toolBarView.frame = CGRect.init(x: 0, y: screenH - self.toolBarView.frame.size.height - 64, width: screenW, height: self.toolBarView.frame.size.height)
            
                self.resetChatList()
            })
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
            
            self.toolBarView.frame = CGRect.init(x: 0, y: screenH - self.toolBarView.height - keyBoardFrame.size.height - 64, width: screenW, height: self.toolBarView.height)
            
            self.emotionview.frame = emotionUpFrame
            
            self.resetChatList()
        })
    
    }
    
    //处理键盘收起
    func HandleKeyBoardHide() {
        
        //键盘收起
        self.toolBarView.toolBarEmotionBtn.isSelected = true
        
        UIView.animate(withDuration: emotionTipTime, animations: {
            
            self.toolBarView.frame = CGRect.init(x: 0, y: screenH - self.toolBarView.height - self.emotionview.height - 64, width: screenW, height: self.toolBarView.height)
            
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
            
        }else {
        
            toolBarView.textView.resignFirstResponder()
            
            emotionBtn.isSelected = true
            
            UIView.animate(withDuration: emotionTipTime, animations: { 
                
                self.emotionview.frame = emotionUpFrame
                
                self.toolBarView.frame = CGRect.init(x: 0, y: screenH - self.toolBarView.height - self.emotionview.height - 64, width: screenW, height: self.toolBarView.height)
                
                self.resetChatList()
            })
        }
    }
    
    //重设tabbleview的frame并根据是否在底部来执行滚动到底部的动画（不在底部就不执行，在底部才执行）
    func resetChatList() {
    
        let offSetY:CGFloat = tableView.contentSize.height - tableView.height;
        //判断是否滚动到底部，会有一个误差值
        if tableView.contentOffset.y > offSetY - 5 || tableView.contentOffset.y > offSetY + 5 {
            
            self.tableView.frame = CGRect.init(x: 0, y: self.tableView.y, width: screenW, height: self.toolBarView.y)
            
            ScrollTableViewToBottom()
            
        }else {
            
            self.tableView.frame = CGRect.init(x: 0, y: self.tableView.y, width: screenW, height: self.toolBarView.y)
        }
    }
    
    //滚动到底部
    func ScrollTableViewToBottom() {
        
        let indexPath:NSIndexPath = NSIndexPath.init(row: self.dataSource.count - 1, section: 0)
        
        self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.bottom, animated: false)
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
            
            self.toolBarView.y = screenH - self.toolBarView.height - self.emotionview.height - 64;
            
        }else {
            
            self.toolBarView.y = screenH - self.toolBarView.height - self.keyBoardH - 64;
        }
        if (textView.text.characters.count > 0) {
            
            self.emotionview.sendBtn.isSelected = true;
            
        }else {
            
            self.emotionview.sendBtn.isSelected = false;
        }
    
        self.tableView.height = self.toolBarView.y
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            
            sendMessage()
            
            return false
        }
        
        return true;
    }
    
    //keyBoard代理
    func emotionView_sBtnDidClick(btn:UIButton) {
    
       textViewDidChange(toolBarView.textView)
        
        if btn.tag == 44 {//发送按钮
            
           sendMessage()
        }
        
    }
    
    func gifBtnClick(btn:UIButton) {
    
        
    }
    
    //发送消息
    func sendMessage() {
        
        var messageText = String()
        
        if toolBarView.textView.textStorage.length != 0 {
            
            messageText = toolBarView.textView.textStorage.getPlainString()
        }else {
        
           messageText = "[憨笑]彩笔，怎么可以输入空格呢?[得意]"
        }
        
        createDataSource(text: messageText)
        
        refreshChatList()
        
    }
    
    //创建一条数据
    func createDataSource(text:String) {
    
        let cellFrame:LiuqsChatCellFrame = LiuqsChatCellFrame()
        
        let message:LiuqsChatMessage = LiuqsChatMessage()
        
        message.message = text
        
        message.userName = "鸣人"
        
        message.currentUserType = userType.other
        
        cellFrame.message = message
        
        dataSource.add(cellFrame)
        
    }
    
    //刷新UI
    func refreshChatList() {
    
        toolBarView.textView.text = ""
        
        textViewDidChange(toolBarView.textView)
        
        let indexPath:NSIndexPath = NSIndexPath.init(row: dataSource.count - 1, section: 0)
        
        tableView.insertRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)

        self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
    }
    
}






