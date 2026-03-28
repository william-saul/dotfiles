-- general

swayimg.gallery.bind_reset()
swayimg.gallery.set_thumb_size(450)
swayimg.imagelist.set_order("numeric")
swayimg.imagelist.enable_reverse(true)
swayimg.imagelist.enable_fsmon(true)
swayimg.gallery.enable_preload(false)
swayimg.gallery.limit_cache(100)

-- vim bindings (gallery)

swayimg.gallery.on_key("j", function()
    swayimg.gallery.switch_image("down")
end)

swayimg.gallery.on_key("k", function()
    swayimg.gallery.switch_image("up")
end)

swayimg.gallery.on_key("h", function()
    swayimg.gallery.switch_image("left")
end)

swayimg.gallery.on_key("l", function()
    swayimg.gallery.switch_image("right")
end)

swayimg.gallery.on_key("u", function()
    swayimg.gallery.switch_image("pgup")
end)

swayimg.gallery.on_key("d", function()
    swayimg.gallery.switch_image("pgdown")
end)

swayimg.gallery.on_key("g", function()
    swayimg.gallery.switch_image("first")
end)

swayimg.gallery.on_key("Shift-g", function()
    swayimg.gallery.switch_image("last")
end)

-- toggle gallery --> viewer

swayimg.gallery.on_key("Return", function()
    local img = swayimg.gallery.get_image()
    swayimg.set_mode("viewer")
    swayimg.viewer.open(img.path)
end)

-- vim bindings (viewer)

swayimg.viewer.on_key("p", function()
    swayimg.viewer.switch_image("prev")
end)

swayimg.viewer.on_key("n", function()
    swayimg.viewer.switch_image("next")
end)

swayimg.viewer.on_key("g", function()
    swayimg.viewer.switch_image("first")
end)

swayimg.viewer.on_key("Shift-g", function()
    swayimg.viewer.switch_image("last")
end)

-- vim panning (viewer)

local pan_step = 40

swayimg.viewer.on_key("l", function()
    local pos = swayimg.viewer.get_position()
    swayimg.viewer.set_abs_position(pos.x - pan_step, pos.y)
end)

swayimg.viewer.on_key("h", function()
    local pos = swayimg.viewer.get_position()
    swayimg.viewer.set_abs_position(pos.x + pan_step, pos.y)
end)

swayimg.viewer.on_key("k", function()
    local pos = swayimg.viewer.get_position()
    swayimg.viewer.set_abs_position(pos.x, pos.y + pan_step)
end)

swayimg.viewer.on_key("j", function()
    local pos = swayimg.viewer.get_position()
    swayimg.viewer.set_abs_position(pos.x, pos.y - pan_step)
end)

-- vim zoom in/out (gallery & viewer)

local function clamp(x, min, max)
    return math.max(min, math.min(max, x))
end

swayimg.gallery.on_key("Shift-j", function()
    local size = swayimg.gallery.get_thumb_size()
    swayimg.gallery.set_thumb_size(math.max(size - 20, 50))
end)

swayimg.gallery.on_key("Shift-k", function()
    local size = swayimg.gallery.get_thumb_size()
    swayimg.gallery.set_thumb_size(math.min(size + 20, 500))
end)

swayimg.viewer.on_key("Shift-j", function()
    local scale = swayimg.viewer.get_scale()
    swayimg.viewer.set_abs_scale(clamp(scale * 0.9, 0.1, 10))
end)

swayimg.viewer.on_key("Shift-k", function()
    local scale = swayimg.viewer.get_scale()
    swayimg.viewer.set_abs_scale(clamp(scale * 1.1, 0.1, 10))
end)

-- help message (gallery & viewer)

local function show_help(mode)
    if mode == "gallery" then
        swayimg.text.set_status(
            "Help:\n\n" ..
            "shift+j/k - zoom\n" ..
            "j/k/h/l - move\n" ..
            "u/d - page up/down\n" ..
            "g/G - first/last\n" ..
            "Enter - open"
        )
    elseif mode == "viewer" then
        swayimg.text.set_status(
            "Help:\n\n" ..
            "shift+j/k - zoom\n" ..
            "j/k/h/l - pan\n" ..
            "n/p - next/prev\n" ..
            "g/G - first/last"
        )
    end
end

swayimg.gallery.on_key("F1", function()
    show_help("gallery")
end)

swayimg.viewer.on_key("F1", function()
    show_help("viewer")
end)
