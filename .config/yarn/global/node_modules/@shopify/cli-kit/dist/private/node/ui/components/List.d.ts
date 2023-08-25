import { InlineToken, TokenItem } from './TokenizedText.js';
import { TextProps } from 'ink';
import { FunctionComponent } from 'react';
interface ListProps {
    title?: TokenItem<InlineToken>;
    items: TokenItem<InlineToken>[];
    ordered?: boolean;
    margin?: boolean;
    color?: TextProps['color'];
}
/**
 * `List` displays an unordered or ordered list with text aligned with the bullet point
 * and wrapped to the container width.
 */
declare const List: FunctionComponent<ListProps>;
export { List };
