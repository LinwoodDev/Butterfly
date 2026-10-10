import { execFileSync } from "node:child_process";

const versionRefs = {
  nightly: "refs/tags/nightly",
  stable: "refs/tags/stable",
  develop: "refs/remotes/origin/develop",
  main: "refs/remotes/origin/main",
};

function readVersion(ref: string) {
  let pubspec: string;
  try {
    pubspec = execFileSync("git", ["show", `${ref}:app/pubspec.yaml`], {
      encoding: "utf8",
      stdio: ["ignore", "pipe", "pipe"],
    });
  } catch (cause) {
    throw new Error(
      `Cannot read app/pubspec.yaml from ${ref}. Fetch the metadata refs as described in docs/README.md.`,
      { cause },
    );
  }

  const version = /^version:\s*([^\s+]+)(?:\+\d+)?\s*$/m.exec(pubspec)?.[1];
  if (!version) {
    throw new Error(`Missing or invalid app version in ${ref}:app/pubspec.yaml`);
  }
  return version;
}

export function GET() {
  const version = Object.fromEntries(
    Object.entries(versionRefs).map(([channel, ref]) => [channel, readVersion(ref)]),
  );
  return Response.json({ version });
}
