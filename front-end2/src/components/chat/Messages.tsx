import React from 'react'
import { MessageType } from '../../types';
import { Message } from './Message';

type MessagesProps = {
    className?: string;
    messages: MessageType[];
}

export function Messages({ className, messages }: MessagesProps) {
    return (
        <div className = "d-flex flex-column">
            {messages && messages.map((message, index) => (
                <Message
                    className={"m-2 ".concat(message.me ? "align-self-end" : "align-self-start")}
                    text={message.text}
                    key={index}
                />
            ))
            }

        </div>
    )
}
