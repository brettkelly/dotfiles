import { AbortSignal } from '../../../../public/node/abort.js';
import { FunctionComponent } from 'react';
export interface TextPromptProps {
    message: string;
    onSubmit: (value: string) => void;
    defaultValue?: string;
    password?: boolean;
    validate?: (value: string) => string | undefined;
    allowEmpty?: boolean;
    emptyDisplayedValue?: string;
    abortSignal?: AbortSignal;
}
declare const TextPrompt: FunctionComponent<TextPromptProps>;
export { TextPrompt };
