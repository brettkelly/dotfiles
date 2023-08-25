import { AbortSignal } from '../../../../public/node/abort.js';
export default function useAbortSignal(abortSignal?: AbortSignal): {
    isAborted: boolean;
};
