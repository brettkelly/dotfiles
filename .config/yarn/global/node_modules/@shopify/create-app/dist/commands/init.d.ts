/// <reference types="node" resolution-mode="require"/>
import Command from '@shopify/cli-kit/node/base-command';
import { URL } from 'url';
export default class Init extends Command {
    static aliases: string[];
    static flags: {
        name: import("@oclif/core/lib/interfaces/parser.js").OptionFlag<string | undefined, import("@oclif/core/lib/interfaces/parser.js").CustomOptions>;
        path: import("@oclif/core/lib/interfaces/parser.js").OptionFlag<string, import("@oclif/core/lib/interfaces/parser.js").CustomOptions>;
        template: import("@oclif/core/lib/interfaces/parser.js").OptionFlag<string | undefined, import("@oclif/core/lib/interfaces/parser.js").CustomOptions>;
        'package-manager': import("@oclif/core/lib/interfaces/parser.js").OptionFlag<string | undefined, import("@oclif/core/lib/interfaces/parser.js").CustomOptions>;
        local: import("@oclif/core/lib/interfaces/parser.js").BooleanFlag<boolean>;
        'no-color': import("@oclif/core/lib/interfaces/parser.js").BooleanFlag<boolean>;
        verbose: import("@oclif/core/lib/interfaces/parser.js").BooleanFlag<boolean>;
    };
    run(): Promise<void>;
    validateTemplateValue(template: string | undefined): void;
    parseURL(url: string): URL | undefined;
}
