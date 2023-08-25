import { runCreateCLI } from '@shopify/cli-kit/node/cli';
async function runCreateAppCLI(development) {
    await runCreateCLI({
        moduleURL: import.meta.url,
        development,
    });
}
export default runCreateAppCLI;
//# sourceMappingURL=index.js.map