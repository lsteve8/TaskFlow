from pathlib import Path

label_root = Path("datasets/mldatazoom-7bb7f5db/labels")

mapping = {
    "80": "0",  # toolhead
    "81": "1",  # embryo
}

for txt_file in label_root.rglob("*.txt"):
    lines = txt_file.read_text().strip().splitlines()
    new_lines = []

    for line in lines:
        parts = line.split()
        if not parts:
            continue

        old_class = parts[0]
        if old_class in mapping:
            parts[0] = mapping[old_class]
        else:
            print(f"Warning: unexpected class {old_class} in {txt_file}")

        new_lines.append(" ".join(parts))

    txt_file.write_text("\n".join(new_lines) + "\n")

print("Done fixing labels.")