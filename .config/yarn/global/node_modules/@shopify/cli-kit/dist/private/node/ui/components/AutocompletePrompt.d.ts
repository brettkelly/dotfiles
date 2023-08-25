import { SelectInputProps, Item as SelectItem } from './SelectInput.js';
import { InfoTableProps } from './Prompts/InfoTable.js';
import { AbortSignal } from '../../../../public/node/abort.js';
import React, { ReactElement } from 'react';
export interface SearchResults<T> {
    data: SelectItem<T>[];
    meta?: {
        hasNextPage: boolean;
    };
}
export interface AutocompletePromptProps<T> {
    message: string;
    choices: SelectInputProps<T>['items'];
    onSubmit: (value: T) => void;
    infoTable?: InfoTableProps['table'];
    hasMorePages?: boolean;
    search: (term: string) => Promise<SearchResults<T>>;
    abortSignal?: AbortSignal;
}
declare function AutocompletePrompt<T>({ message, choices: initialChoices, infoTable, onSubmit, search, hasMorePages: initialHasMorePages, abortSignal, }: React.PropsWithChildren<AutocompletePromptProps<T>>): ReactElement | null;
export { AutocompletePrompt };
