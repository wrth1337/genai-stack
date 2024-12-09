import { ChangeEvent, useState } from "react";

type TextinputProps = {
    className?: string;
    onSendInput: any;
}

export function Textinput({ className, onSendInput }: TextinputProps) {
    const [question, setQuestion] = useState<string>("");
    const [useRag, setuseRag] = useState<boolean>(false);

    function handleChange(e: ChangeEvent<HTMLInputElement>) {
        setQuestion(e.target.value);
    }

    function askQuestion(event: { preventDefault: () => void; }) {
        event.preventDefault();
        onSendInput(question, useRag)
        setQuestion("");
    }

    return (
        <div
            className={className}
        >
            <form className="form" onSubmit={askQuestion}>
                <div className="form-check form-switch mb-2">
                    <input className="form-check-input" type="checkbox" role="switch" id="ragSwitch" onChange={() => setuseRag(!useRag)}/>
                        <label className="form-check-label" htmlFor="ragSwitch">Set RAG</label>
                </div>

                <input
                    placeholder="What coding related question can I help you with?"
                    disabled={false}
                    className="w-100"
                    value={question}
                    onChange={handleChange}
                    type="text"
                />
            </form>
        </div>
    )
}