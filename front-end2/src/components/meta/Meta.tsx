import { Metadata } from "../../types";

type MetaProps = {
	className?: string;
	metadata?: Metadata; 
}

export function Meta({ className, metadata }: MetaProps) {
	return (
		<div className={"".concat(className ?? '')}>
			<h1>Metadata</h1>
			<p>Temperature: {metadata?.temperature}</p>
			<p>Model: {metadata?.modelName}</p>

			<br/>
			<h5>Promt:</h5>
			<p>{metadata?.systemPrompt}</p>
		</div>
	)
}
