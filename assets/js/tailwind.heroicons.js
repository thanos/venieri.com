// tailwind.heroicons.js

// add fs, plugin and path to the top of the file
const plugin = require("tailwindcss/plugin");
const fs = require("fs");
const path = require("path");

module.exports = plugin(function ({ matchComponents, theme }) {
  const iconsDir = path.join(__dirname, "../../deps/heroicons/optimized");
  const values = {};
  const icons = [
    ["", "/24/outline"],
    ["-solid", "/24/solid"],
    ["-mini", "/20/solid"],
    ["-micro", "/16/solid"],
  ];
  icons.forEach(([suffix, dir]) => {
    fs.readdirSync(path.join(iconsDir, dir)).forEach((file) => {
      const name = path.basename(file, ".svg") + suffix;
      values[name] = { name, fullPath: path.join(iconsDir, dir, file) };
    });
  });
  matchComponents(
    {
      hero: ({ name, fullPath }) => {
        let content = fs
          .readFileSync(fullPath)
          .toString()
          .replace(/\r?\n|\r/g, "");
        content = encodeURIComponent(content);
        let size = theme("spacing.6");
        if (name.endsWith("-mini")) {
          size = theme("spacing.5");
        } else if (name.endsWith("-micro")) {
          size = theme("spacing.4");
        }
        return {
          [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
          "-webkit-mask": `var(--hero-${name})`,
          mask: `var(--hero-${name})`,
          "mask-repeat": "no-repeat",
          "background-color": "currentColor",
          "vertical-align": "middle",
          display: "inline-block",
          width: size,
          height: size,
        };
      },
    },
    { values },
  );
});
