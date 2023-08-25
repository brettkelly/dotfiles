import { SelectInputProps } from './SelectInput.js';
import { InfoTableProps } from './Prompts/InfoTable.js';
import { InlineToken, LinkToken, TokenItem } from './TokenizedText.js';
import { AbortSignal } from '../../../../public/node/abort.js';
import React, { ReactElement } from 'react';
export interface SelectPromptProps<T> {
    message: TokenItem<Exclude<InlineToken, LinkToken>>;
    choices: SelectInputProps<T>['items'];
    onSubmit: (value: T) => void;
    infoTable?: InfoTableProps['table'];
    defaultValue?: T;
    submitWithShortcuts?: boolean;
    abortSignal?: AbortSignal;
}
declare function SelectPrompt<T>({ message, choices, infoTable, onSubmit, defaultValue, submitWithShortcuts, abortSignal, }: React.PropsWithChildren<SelectPromptProps<T>>): ReactElement | null;
export { SelectPrompt };
