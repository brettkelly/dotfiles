import { treeKill } from './tree-kill.js';
import { collectLog, consoleLog, outputWhereAppropriate } from '../../public/node/output.js';
import { isUnitTest } from '../../public/node/context/local.js';
import { render as inkRender } from 'ink';
import { EventEmitter } from 'events';
export function renderOnce(element, { logLevel = 'info', logger = consoleLog, renderOptions }) {
    const { output, unmount } = renderString(element, renderOptions);
    if (output) {
        if (isUnitTest())
            collectLog(logLevel, output);
        outputWhereAppropriate(logLevel, logger, output, { skipUIEvent: true });
    }
    unmount();
    return output;
}
export function render(element, options) {
    const { waitUntilExit } = inkRender(element, options);
    return waitUntilExit();
}
export class Stdout extends EventEmitter {
    constructor(options) {
        super();
        this.frames = [];
        this.write = (frame) => {
            this.frames.push(frame);
            this._lastFrame = frame;
        };
        this.lastFrame = () => {
            return this._lastFrame;
        };
        this.columns = options.columns ?? 80;
        this.rows = options.rows ?? 80;
    }
}
const renderString = (element, renderOptions) => {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const stdout = renderOptions?.stdout ?? new Stdout({ columns: process.stdout.columns });
    const instance = inkRender(element, {
        stdout,
        debug: true,
        exitOnCtrlC: false,
        patchConsole: false,
    });
    return {
        output: stdout.lastFrame(),
        unmount: instance.unmount,
    };
};
export function handleCtrlC(input, key) {
    if (input === 'c' && key.ctrl) {
        // Exceptions thrown in hooks aren't caught by our errorHandler.
        treeKill('SIGINT');
    }
}
//# sourceMappingURL=ui.js.map