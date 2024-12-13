export type Response = {
    answer: Answer;
    metadata: Metadata;
}

export type Answer = {
    answer: string;
}

export type Metadata = {
    temperature: string;
    systemPrompt: string;
    modelName: string;
}

export type MessageType = {
    text: string;
    me: boolean;
}


export enum ChatStates {
    RECEIVING,
    IDLE
}