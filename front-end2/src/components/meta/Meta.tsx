import { Metadata } from "../../types";

type MetaProps = {
	className?: string;
	metadata?: Metadata; 
}

export function Meta({ className, metadata }: MetaProps) {
	return (
		<div className={"".concat(className ?? '')}>
			<h1>Metadata</h1>
			<p>{metadata?.temperature}</p>
			<p>{metadata?.systemPrompt}</p>
		</div>
	)
}
