import { useState } from "react";
import { Chat } from "./components/chat/Chat"
import { ChatStates, MessageType, Response } from "./types";
import { Meta } from "./components/meta/Meta";

const API_ENDPOINT = "http://localhost:8604/query";


function App() {
	const [response, setResponse] = useState<Response>();
	const [chatState, setChatState] = useState<ChatStates>(ChatStates.IDLE);
	const [messages, setMessages] = useState<MessageType[]>([]);
	
	const handleSendInput = async (question : string, rag : boolean) => {
		setMessages(messages=> [...messages, {text: question, me: true}]);
		try {
			console.log("Hier API Call")
			console.log("question:" + question)
			console.log("rag:" + rag)
			
			try {
				const response = await fetch(
					`${API_ENDPOINT}?text=${encodeURI(question)}&rag=${rag}`,
					{ method: 'GET'}
				);

				if (response.ok && response.status !== 204) {
					const data: any = await response.json();
					console.log(data.result);
					setMessages(messages=> [...messages, {text: data.result, me: false}]);

				} else if (response.status !== 204) {
					console.error("Failed to ask Bot:", response.statusText);
					setMessages(messages=> [...messages, {text: "ERROR: " + response.statusText, me: false}]);
				}
			} catch (error) {
				console.error("Error:", error);
				setMessages(messages=> [...messages, {text: "ERROR: " + error, me: false}]);
			}


		} catch (error) {
			
		}
	}

	return (
		<div className="container-fluid" style={{ height: "100vh" }}>
			<div className="row h-100">
				<div className='col-3'><h1>History</h1></div>
				<div className='col-5'><Chat className="h-100" onSendInput={handleSendInput} messages={messages} /></div>
				<div className='col-4'><Meta /></div>
			</div>
		</div>
	)
}

export default App
