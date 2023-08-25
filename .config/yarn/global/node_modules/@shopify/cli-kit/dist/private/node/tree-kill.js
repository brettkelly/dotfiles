import { printEventsJson } from './demo-recorder.js';
import originalTreeKill from 'tree-kill';
export function treeKill(signal) {
    printEventsJson();
    originalTreeKill(process.pid, signal);
}
//# sourceMappingURL=tree-kill.js.map