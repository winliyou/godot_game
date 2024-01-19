shader_type canvas_item;

void fragment() {
    // 使用源颜色（SRC_COLOR）覆盖目标颜色
    COLOR = texture(TEXTURE, UV) * SRC_COLOR;
}
