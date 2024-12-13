import { ChatStates, MessageType } from "../../types";
import { Messages } from "./Messages";
import { Textinput } from "./Textinput";

type ChatProps = {
    className?: string;
	onSendInput: any;
	messages: MessageType[];
	chatState: ChatStates;
}

export function Chat({ className, onSendInput, messages, chatState }: ChatProps) {
	return (
		<div className={"container-fluid d-flex flex-column ".concat(className ?? '')}>
			<h1>Chat</h1>
			<div className="flex-fill">
				<Messages
					messages={messages}
				/>
			</div>

			<Textinput className="w-90 mb-2" onSendInput={onSendInput} chatState={chatState}/>
		</div>
	)
}