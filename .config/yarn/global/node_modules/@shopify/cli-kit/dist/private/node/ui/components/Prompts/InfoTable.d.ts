import { InlineToken, TokenItem } from '../TokenizedText.js';
import { TextProps } from 'ink';
import { FunctionComponent } from 'react';
type Items = TokenItem<InlineToken>[];
export interface InfoTableSection {
    color?: TextProps['color'];
    header: string;
    helperText?: string;
    items: Items;
}
export interface InfoTableProps {
    table: {
        [header: string]: Items;
    } | InfoTableSection[];
}
declare const InfoTable: FunctionComponent<InfoTableProps>;
export { InfoTable };
