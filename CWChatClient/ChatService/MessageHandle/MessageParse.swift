//
//  MessageParse.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation
import XMPPFramework

class MessageParse: NSObject {
    
    lazy var messageHandle: MessageHandle = {
        let messageHandle = MessageHandle()
        messageHandle.delegate = self
        messageHandle.nextMessageHandle = self.chatMessageHandle
        return messageHandle
    }()
    
    lazy var chatMessageHandle: ChatMessageHandle = {
        let chatMessageHandle = ChatMessageHandle()
        chatMessageHandle.delegate = self
        return chatMessageHandle
    }()
    
    func handle(message: XMPPMessage) {
        chatMessageHandle.handleMessage(message)
    }
}

// MARK: - CWMessageHandleDelegate
extension MessageParse: MessageHandleDelegate {
    
    private func handMessageComplete(message: Message, conversationId: String) {
        // 先保存消息
        let chatService = ChatClient.share.chatManager as! ChatService
        chatService.receive(message: message, conversationId: conversationId)
    
    }
    
}