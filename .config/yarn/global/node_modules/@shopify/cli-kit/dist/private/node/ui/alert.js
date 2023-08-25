import { Alert } from './components/Alert.js';
import { renderOnce } from '../ui.js';
import { consoleLog, consoleWarn } from '../../../public/node/output.js';
import { recordUIEvent } from '../demo-recorder.js';
import React from 'react';
const typeToLogLevel = {
    info: 'info',
    warning: 'warn',
    success: 'info',
};
const typeToLogger = {
    info: consoleLog,
    warning: consoleWarn,
    success: consoleLog,
};
export function alert({ type, headline, body, nextSteps, reference, link, customSections, orderedNextSteps = false, renderOptions, }) {
    // eslint-disable-next-line prefer-rest-params
    const { type: alertType, ...eventProps } = arguments[0];
    recordUIEvent({ type, properties: eventProps });
    return renderOnce(React.createElement(Alert, { type: type, headline: headline, body: body, nextSteps: nextSteps, reference: reference, link: link, orderedNextSteps: orderedNextSteps, customSections: customSections }), { logLevel: typeToLogLevel[type], logger: typeToLogger[type], renderOptions });
}
//# sourceMappingURL=alert.js.map