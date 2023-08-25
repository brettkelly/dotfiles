import { TextInput } from './TextInput.js';
import { TokenizedText } from './TokenizedText.js';
import { handleCtrlC } from '../../ui.js';
import useLayout from '../hooks/use-layout.js';
import { messageWithPunctuation } from '../utilities.js';
import useAbortSignal from '../hooks/use-abort-signal.js';
import React, { useCallback, useState } from 'react';
import { Box, useApp, useInput, Text } from 'ink';
import figures from 'figures';
const TextPrompt = ({ message, onSubmit, validate, defaultValue = '', password = false, allowEmpty = false, emptyDisplayedValue = '(empty)', abortSignal, }) => {
    if (password && defaultValue) {
        throw new Error("Can't use defaultValue with password");
    }
    const validateAnswer = useCallback((value) => {
        if (validate) {
            return validate(value);
        }
        if (value.length === 0 && !allowEmpty)
            return 'Type an answer to the prompt.';
        return undefined;
    }, [allowEmpty, validate]);
    const { oneThird } = useLayout();
    const [answer, setAnswer] = useState('');
    const answerOrDefault = answer.length > 0 ? answer : defaultValue;
    const displayEmptyValue = answerOrDefault === '';
    const displayedAnswer = displayEmptyValue ? emptyDisplayedValue : answerOrDefault;
    const { exit: unmountInk } = useApp();
    const [submitted, setSubmitted] = useState(false);
    const [error, setError] = useState(undefined);
    const shouldShowError = submitted && error;
    const color = shouldShowError ? 'red' : 'cyan';
    const underline = new Array(oneThird - 3).fill('▔');
    const { isAborted } = useAbortSignal(abortSignal);
    useInput((input, key) => {
        handleCtrlC(input, key);
        if (key.return) {
            setSubmitted(true);
            const error = validateAnswer(answerOrDefault);
            setError(error);
            if (!error) {
                onSubmit(answerOrDefault);
                unmountInk();
            }
        }
    });
    return isAborted ? null : (React.createElement(Box, { flexDirection: "column", marginBottom: 1, width: oneThird },
        React.createElement(Box, null,
            React.createElement(Box, { marginRight: 2 },
                React.createElement(Text, null, "?")),
            React.createElement(TokenizedText, { item: messageWithPunctuation(message) })),
        submitted && !error ? (React.createElement(Box, null,
            React.createElement(Box, { marginRight: 2 },
                React.createElement(Text, { color: "cyan" }, figures.tick)),
            React.createElement(Box, { flexGrow: 1 },
                React.createElement(Text, { color: "cyan", dimColor: displayEmptyValue }, password ? '*'.repeat(answer.length) : displayedAnswer)))) : (React.createElement(Box, { flexDirection: "column" },
            React.createElement(Box, null,
                React.createElement(Box, { marginRight: 2 },
                    React.createElement(Text, { color: color }, `>`)),
                React.createElement(Box, { flexGrow: 1 },
                    React.createElement(TextInput, { value: answer, onChange: (answer) => {
                            setAnswer(answer);
                            setSubmitted(false);
                        }, defaultValue: defaultValue, color: color, password: password }))),
            React.createElement(Box, { marginLeft: 3 },
                React.createElement(Text, { color: color }, underline)),
            shouldShowError ? (React.createElement(Box, { marginLeft: 3 },
                React.createElement(Text, { color: color }, error))) : null))));
};
export { TextPrompt };
//# sourceMappingURL=TextPrompt.js.map