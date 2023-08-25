import { PackageManager, PackageJson } from '@shopify/cli-kit/node/node-package-manager';
interface UpdateCLIDependenciesOptions {
    directory: string;
    packageJSON: PackageJson;
    local: boolean;
}
export declare function updateCLIDependencies({ packageJSON, local }: UpdateCLIDependenciesOptions): Promise<PackageJson>;
export declare function getDeepInstallNPMTasks({ from, packageManager, }: {
    from: string;
    packageManager: PackageManager;
}): Promise<void>;
export {};
