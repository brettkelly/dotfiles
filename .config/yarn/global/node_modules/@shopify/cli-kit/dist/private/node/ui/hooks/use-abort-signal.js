import { useApp } from 'ink';
import { useLayoutEffect, useState } from 'react';
export default function useAbortSignal(abortSignal) {
    const { exit: unmountInk } = useApp();
    const [isAborted, setIsAborted] = useState(false);
    useLayoutEffect(() => {
        abortSignal?.addEventListener('abort', () => {
            setIsAborted(true);
            unmountInk();
        });
    }, []);
    return { isAborted };
}
//# sourceMappingURL=use-abort-signal.js.map