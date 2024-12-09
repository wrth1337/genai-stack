import React, { useEffect, useState } from 'react';
import { marked } from "marked";

type MessageProps = {
    className?: string;
    text: string;
};

export function Message({ className, text }: MessageProps) {
    const [htmlContent, setHtmlContent] = useState<string>("");

    useEffect(() => {
        const processMarkdown = async () => {
            try {
                const html = await marked.parse(text);
                setHtmlContent(html);
            } catch (error) {
                console.error("Fehler beim Verarbeiten des Markdown-Inhalts:", error);
                setHtmlContent("<p>Fehler beim Laden des Inhalts</p>");
            }
        };

        processMarkdown();
    }, [text]);

    return (
        <div
            className={`p-3 message rounded ${className ?? ""}`}
            style={{ backgroundColor: "lightgrey", maxWidth: "75%" }}
            dangerouslySetInnerHTML={{ __html: htmlContent }}
        />
    );
}
