interface InitOptions {
    name: string;
    directory: string;
    template: string;
    packageManager: string | undefined;
    local: boolean;
}
declare function init(options: InitOptions): Promise<void>;
export default init;
