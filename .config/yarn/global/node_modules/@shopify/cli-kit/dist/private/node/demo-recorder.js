import { isTruthy } from './context/utilities.js';
class DemoRecorder {
    constructor() {
        this.recorded = [];
        this.sleepStart = Date.now();
        this.command = ['shopify', ...process.argv.slice(2)].join(' ');
    }
    addEvent({ type, properties }) {
        if (type === 'taskbar') {
            this.resetSleep();
        }
        else {
            this.addSleep();
        }
        this.recorded.push({ type, properties: JSON.parse(JSON.stringify(properties)) });
        this.sleepStart = Date.now();
    }
    recordedEventsJson() {
        return JSON.stringify({
            command: this.command,
            steps: this.withFormattedConcurrent(this.recorded),
        }, null, 2);
    }
    addSleep() {
        const duration = (Date.now() - this.sleepStart) / 1000;
        this.sleepStart = Date.now();
        if (duration > 0.1) {
            this.recorded.push({ type: 'sleep', properties: { duration } });
        }
    }
    resetSleep() {
        this.sleepStart = Date.now();
    }
    addOrUpdateConcurrentOutput({ prefix, index, output, }, { footer }) {
        let last = this.recorded[this.recorded.length - 1];
        if (last?.type === 'concurrent') {
            // Don't sleep between concurrent lines
            this.resetSleep();
        }
        else {
            const eventProperties = {
                type: 'concurrent',
                properties: { processes: [], concurrencyStart: Date.now() },
            };
            if (footer)
                eventProperties.properties.footer = footer;
            this.addEvent(eventProperties);
            last = this.recorded[this.recorded.length - 1];
        }
        const { processes } = last.properties;
        while (processes.length <= index) {
            processes.push({ prefix: '', steps: [] });
        }
        processes[index].prefix = prefix;
        processes[index].steps.push({ timestamp: Date.now(), endMessage: output });
    }
    withFormattedConcurrent(recorded) {
        return recorded.map((event) => {
            if (event.type === 'concurrent') {
                const { processes, footer, concurrencyStart } = event.properties;
                const formatted = processes.map(({ prefix, steps }) => {
                    let mostRecentTimestamp = concurrencyStart;
                    const formattedSteps = steps.map(({ timestamp, endMessage }) => {
                        const duration = (timestamp - mostRecentTimestamp) / 1000;
                        mostRecentTimestamp = timestamp;
                        return { duration, endMessage };
                    });
                    return { prefix, steps: formattedSteps };
                });
                return { type: 'concurrent', properties: { footer, processes: formatted } };
            }
            return event;
        });
    }
}
class NoopDemoRecorder {
    addEvent(_event) { }
    recordedEventsJson() {
        return JSON.stringify({ steps: [] }, null, 2);
    }
    addSleep() { }
    resetSleep() { }
    addOrUpdateConcurrentOutput(..._args) { }
}
let _instance;
function ensureInstance() {
    if (!_instance) {
        if (isRecording()) {
            _instance = new DemoRecorder();
        }
        else {
            _instance = new NoopDemoRecorder();
        }
    }
}
export function initDemoRecorder() {
    ensureInstance();
}
export function recordUIEvent(event) {
    ensureInstance();
    _instance.addEvent(event);
}
export function resetRecordedSleep() {
    ensureInstance();
    _instance.resetSleep();
}
export function printEventsJson() {
    if (isRecording()) {
        ensureInstance();
        _instance.addSleep();
        // eslint-disable-next-line no-console
        console.log(_instance.recordedEventsJson());
    }
}
export function addOrUpdateConcurrentUIEventOutput(data, componentData) {
    ensureInstance();
    _instance.addOrUpdateConcurrentOutput(data, componentData);
}
function isRecording() {
    return isTruthy(process.env.RECORD_DEMO);
}
//# sourceMappingURL=demo-recorder.js.map