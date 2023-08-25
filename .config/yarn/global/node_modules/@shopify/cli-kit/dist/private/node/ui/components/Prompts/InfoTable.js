import { List } from '../List.js';
import { capitalize } from '../../../../../public/common/string.js';
import { Box, Text } from 'ink';
import React from 'react';
const InfoTable = ({ table }) => {
    const sections = Array.isArray(table)
        ? table
        : Object.keys(table).map((header) => ({ header, items: table[header], color: undefined, helperText: undefined }));
    const headerColumnWidth = Math.max(...sections.map((section) => {
        return Math.max(...section.header.split('\n').map((line) => {
            return line.length;
        }));
    }));
    return (React.createElement(Box, { flexDirection: "column" }, sections.map((section, index) => (React.createElement(Box, { key: index, marginBottom: index === sections.length - 1 ? 0 : 1 },
        section.header.length > 0 && (React.createElement(Box, { width: headerColumnWidth + 1 },
            React.createElement(Text, { color: section.color },
                capitalize(section.header),
                ":"))),
        React.createElement(Box, { marginLeft: section.header.length > 0 ? 2 : 0, flexGrow: 1, flexDirection: "column" },
            React.createElement(List, { margin: false, items: section.items, color: section.color }),
            section.helperText ? (React.createElement(Box, { marginTop: 1 },
                React.createElement(Text, { color: section.color }, section.helperText))) : null))))));
};
export { InfoTable };
//# sourceMappingURL=InfoTable.js.map