declare module 'astro:content' {
	interface Render {
		'.mdx': Promise<{
			Content: import('astro').MarkdownInstance<{}>['Content'];
			headings: import('astro').MarkdownHeading[];
			remarkPluginFrontmatter: Record<string, any>;
		}>;
	}
}

declare module 'astro:content' {
	interface Render {
		'.md': Promise<{
			Content: import('astro').MarkdownInstance<{}>['Content'];
			headings: import('astro').MarkdownHeading[];
			remarkPluginFrontmatter: Record<string, any>;
		}>;
	}
}

declare module 'astro:content' {
	type Flatten<T> = T extends { [K: string]: infer U } ? U : never;

	export type CollectionKey = keyof AnyEntryMap;
	export type CollectionEntry<C extends CollectionKey> = Flatten<AnyEntryMap[C]>;

	export type ContentCollectionKey = keyof ContentEntryMap;
	export type DataCollectionKey = keyof DataEntryMap;

	type AllValuesOf<T> = T extends any ? T[keyof T] : never;
	type ValidContentEntrySlug<C extends keyof ContentEntryMap> = AllValuesOf<
		ContentEntryMap[C]
	>['slug'];

	export function getEntryBySlug<
		C extends keyof ContentEntryMap,
		E extends ValidContentEntrySlug<C> | (string & {}),
	>(
		collection: C,
		// Note that this has to accept a regular string too, for SSR
		entrySlug: E
	): E extends ValidContentEntrySlug<C>
		? Promise<CollectionEntry<C>>
		: Promise<CollectionEntry<C> | undefined>;

	export function getDataEntryById<C extends keyof DataEntryMap, E extends keyof DataEntryMap[C]>(
		collection: C,
		entryId: E
	): Promise<CollectionEntry<C>>;

	export function getCollection<C extends keyof AnyEntryMap, E extends CollectionEntry<C>>(
		collection: C,
		filter?: (entry: CollectionEntry<C>) => entry is E
	): Promise<E[]>;
	export function getCollection<C extends keyof AnyEntryMap>(
		collection: C,
		filter?: (entry: CollectionEntry<C>) => unknown
	): Promise<CollectionEntry<C>[]>;

	export function getEntry<
		C extends keyof ContentEntryMap,
		E extends ValidContentEntrySlug<C> | (string & {}),
	>(entry: {
		collection: C;
		slug: E;
	}): E extends ValidContentEntrySlug<C>
		? Promise<CollectionEntry<C>>
		: Promise<CollectionEntry<C> | undefined>;
	export function getEntry<
		C extends keyof DataEntryMap,
		E extends keyof DataEntryMap[C] | (string & {}),
	>(entry: {
		collection: C;
		id: E;
	}): E extends keyof DataEntryMap[C]
		? Promise<DataEntryMap[C][E]>
		: Promise<CollectionEntry<C> | undefined>;
	export function getEntry<
		C extends keyof ContentEntryMap,
		E extends ValidContentEntrySlug<C> | (string & {}),
	>(
		collection: C,
		slug: E
	): E extends ValidContentEntrySlug<C>
		? Promise<CollectionEntry<C>>
		: Promise<CollectionEntry<C> | undefined>;
	export function getEntry<
		C extends keyof DataEntryMap,
		E extends keyof DataEntryMap[C] | (string & {}),
	>(
		collection: C,
		id: E
	): E extends keyof DataEntryMap[C]
		? Promise<DataEntryMap[C][E]>
		: Promise<CollectionEntry<C> | undefined>;

	/** Resolve an array of entry references from the same collection */
	export function getEntries<C extends keyof ContentEntryMap>(
		entries: {
			collection: C;
			slug: ValidContentEntrySlug<C>;
		}[]
	): Promise<CollectionEntry<C>[]>;
	export function getEntries<C extends keyof DataEntryMap>(
		entries: {
			collection: C;
			id: keyof DataEntryMap[C];
		}[]
	): Promise<CollectionEntry<C>[]>;

	export function reference<C extends keyof AnyEntryMap>(
		collection: C
	): import('astro/zod').ZodEffects<
		import('astro/zod').ZodString,
		C extends keyof ContentEntryMap
			? {
					collection: C;
					slug: ValidContentEntrySlug<C>;
				}
			: {
					collection: C;
					id: keyof DataEntryMap[C];
				}
	>;
	// Allow generic `string` to avoid excessive type errors in the config
	// if `dev` is not running to update as you edit.
	// Invalid collection names will be caught at build time.
	export function reference<C extends string>(
		collection: C
	): import('astro/zod').ZodEffects<import('astro/zod').ZodString, never>;

	type ReturnTypeOrOriginal<T> = T extends (...args: any[]) => infer R ? R : T;
	type InferEntrySchema<C extends keyof AnyEntryMap> = import('astro/zod').infer<
		ReturnTypeOrOriginal<Required<ContentConfig['collections'][C]>['schema']>
	>;

	type ContentEntryMap = {
		"docs": {
"community/branding.md": {
	id: "community/branding.md";
  slug: "community/branding";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"community/changelog.md": {
	id: "community/changelog.md";
  slug: "community/changelog";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"community/code-of-conduct.md": {
	id: "community/code-of-conduct.md";
  slug: "community/code-of-conduct";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"community/contributing.md": {
	id: "community/contributing.md";
  slug: "community/contributing";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"community/embed/intro.md": {
	id: "community/embed/intro.md";
  slug: "community/embed/intro";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"community/embed/playground.md": {
	id: "community/embed/playground.md";
  slug: "community/embed/playground";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"community/faq.md": {
	id: "community/faq.md";
  slug: "/faq";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"community/intro.md": {
	id: "community/intro.md";
  slug: "/community";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"community/nightly.md": {
	id: "community/nightly.md";
  slug: "/nightly";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"community/pre-1-0.md": {
	id: "community/pre-1-0.md";
  slug: "community/pre-1-0";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"community/privacypolicy.md": {
	id: "community/privacypolicy.md";
  slug: "/privacypolicy";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"community/versions.md": {
	id: "community/versions.md";
  slug: "community/versions";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"downloads/android.mdx": {
	id: "downloads/android.mdx";
  slug: "downloads/android";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".mdx"] };
"downloads/build-your-own.md": {
	id: "downloads/build-your-own.md";
  slug: "downloads/build-your-own";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"downloads/index.mdx": {
	id: "downloads/index.mdx";
  slug: "downloads";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".mdx"] };
"downloads/ios.mdx": {
	id: "downloads/ios.mdx";
  slug: "downloads/ios";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".mdx"] };
"downloads/linux.mdx": {
	id: "downloads/linux.mdx";
  slug: "downloads/linux";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".mdx"] };
"downloads/macos.mdx": {
	id: "downloads/macos.mdx";
  slug: "downloads/macos";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".mdx"] };
"downloads/post-windows.mdx": {
	id: "downloads/post-windows.mdx";
  slug: "downloads/post-windows";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".mdx"] };
"downloads/selfhosting.md": {
	id: "downloads/selfhosting.md";
  slug: "downloads/selfhosting";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"downloads/thank-you.mdx": {
	id: "downloads/thank-you.mdx";
  slug: "downloads/thank-you";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".mdx"] };
"downloads/web.mdx": {
	id: "downloads/web.mdx";
  slug: "downloads/web";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".mdx"] };
"downloads/windows.mdx": {
	id: "downloads/windows.mdx";
  slug: "downloads/windows";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".mdx"] };
"guides/add.md": {
	id: "guides/add.md";
  slug: "guides/add";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/area.mdx": {
	id: "guides/area.mdx";
  slug: "guides/area";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".mdx"] };
"guides/arguments.md": {
	id: "guides/arguments.md";
  slug: "guides/arguments";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/background.mdx": {
	id: "guides/background.mdx";
  slug: "guides/background";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".mdx"] };
"guides/collaboration.md": {
	id: "guides/collaboration.md";
  slug: "guides/collaboration";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/color_picker.md": {
	id: "guides/color_picker.md";
  slug: "guides/color_picker";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/index.mdx": {
	id: "guides/index.mdx";
  slug: "guides";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".mdx"] };
"guides/layers.md": {
	id: "guides/layers.md";
  slug: "guides/layers";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/migrating.md": {
	id: "guides/migrating.md";
  slug: "guides/migrating";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/pack.md": {
	id: "guides/pack.md";
  slug: "guides/pack";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/pages.md": {
	id: "guides/pages.md";
  slug: "guides/pages";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/shortcuts.md": {
	id: "guides/shortcuts.md";
  slug: "guides/shortcuts";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/storage.md": {
	id: "guides/storage.md";
  slug: "guides/storage";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/area.md": {
	id: "guides/tools/area.md";
  slug: "guides/tools/area";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/eraser.md": {
	id: "guides/tools/eraser.md";
  slug: "guides/tools/eraser";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/full_screen.md": {
	id: "guides/tools/full_screen.md";
  slug: "guides/tools/full_screen";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/hand.md": {
	id: "guides/tools/hand.md";
  slug: "guides/tools/hand";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/index.md": {
	id: "guides/tools/index.md";
  slug: "guides/tools";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/label.md": {
	id: "guides/tools/label.md";
  slug: "guides/tools/label";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/laser.md": {
	id: "guides/tools/laser.md";
  slug: "guides/tools/laser";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/layer.md": {
	id: "guides/tools/layer.md";
  slug: "guides/tools/layer";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/path_eraser.md": {
	id: "guides/tools/path_eraser.md";
  slug: "guides/tools/path_eraser";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/pen.md": {
	id: "guides/tools/pen.md";
  slug: "guides/tools/pen";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/presentation.md": {
	id: "guides/tools/presentation.md";
  slug: "guides/tools/presentation";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/redo.md": {
	id: "guides/tools/redo.md";
  slug: "guides/tools/redo";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/select.md": {
	id: "guides/tools/select.md";
  slug: "guides/tools/select";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/shape.md": {
	id: "guides/tools/shape.md";
  slug: "guides/tools/shape";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/spacer.md": {
	id: "guides/tools/spacer.md";
  slug: "guides/tools/spacer";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/stamp.md": {
	id: "guides/tools/stamp.md";
  slug: "guides/tools/stamp";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/texture.md": {
	id: "guides/tools/texture.md";
  slug: "guides/tools/texture";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/tools/undo.md": {
	id: "guides/tools/undo.md";
  slug: "guides/tools/undo";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/utilities.md": {
	id: "guides/utilities.md";
  slug: "guides/utilities";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"guides/waypoints.md": {
	id: "guides/waypoints.md";
  slug: "guides/waypoints";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".md"] };
"index.mdx": {
	id: "index.mdx";
  slug: "index";
  body: string;
  collection: "docs";
  data: any
} & { render(): Render[".mdx"] };
};

	};

	type DataEntryMap = {
		
	};

	type AnyEntryMap = ContentEntryMap & DataEntryMap;

	export type ContentConfig = never;
}
