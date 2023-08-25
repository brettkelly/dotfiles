import { ConcurrentOutputProps } from './ui/components/ConcurrentOutput.js';
interface Event {
    type: string;
    properties: {
        [key: string]: unknown;
    };
    concurrencyStart?: number;
}
export declare function initDemoRecorder(): void;
export declare function recordUIEvent(event: Event): void;
export declare function resetRecordedSleep(): void;
export declare function printEventsJson(): void;
export declare function addOrUpdateConcurrentUIEventOutput(data: {
    prefix: string;
    index: number;
    output: string;
}, componentData: {
    footer: ConcurrentOutputProps['footer'];
}): void;
export {};
