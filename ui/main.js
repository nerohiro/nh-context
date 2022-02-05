let Buttons = [];
let Button = [];

const OpenMenu = (data) => {
    DrawButtons(data)
}

const CloseMenu = () => {
    $(".button").remove();
    $(".buttonDisabled").remove();
    Buttons = [];
    Button = [];
};

const DrawButtons = (data) => {
    for (let i = 0; i < data.length; i++) {
        let context = data[i].context ? data[i].context : ""
        let footer = data[i].footer ? data[i].footer : ""
        let element = $(`
            <div class="${data[i].disabled ? "buttonDisabled" : "button"}" id=` + i + `>
              <div class="header" id=`+ i + `>` + data[i].header + `</div>
              <div class="context" id=`+ i + `>` + context + `</div>
              <div class="footer" id=`+ i + `>` + footer + `</div>
              ${data[i].subMenu && !data[i].disabled ? `<svg class="submenuicon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M5 3l3.057-3 11.943 12-11.943 12-3.057-3 9-9z"/></svg>` : ""}
            </div>`
        );
        $('#buttons').append(element);
        Buttons[i] = element
        Button[i] = data[i]
    }
};

$(document).click(function (event) {
    let $target = $(event.target);
    if ($target.closest('.button').length && $('.button').is(":visible")) {
        let id = event.target.id;
        if (Button[id].disabled) return;
        if (!Button[id].event && !Button[id].args) return;
        PostData(id)
        document.getElementById('imageHover').style.display = 'none';
    }
})

const PostData = (id) => {
    $.post(`https://nh-context/dataPost`, JSON.stringify({ id: id }))
}

const CancelMenu = () => {
    $.post(`https://nh-context/cancel`)
}

window.addEventListener("message", (evt) => {
    const data = evt.data
    const info = data.data
    const action = data.action
    switch (action) {
        case "OPEN_MENU":
            return OpenMenu(info);
        case "CLOSE_MENU":
            return CloseMenu();
        case "CANCEL_MENU":
            return CancelMenu();
        default:
            return;
    }
})

window.addEventListener("keyup", (ev) => {
    if (ev.which == 27) {
        CancelMenu();
        document.getElementById('imageHover').style.display = 'none';
    }
})

window.addEventListener('mousemove', (event) => {
    let $target = $(event.target);
    if ($target.closest('.button:hover').length && $('.button').is(":visible")) {
        let id = event.target.id;
        if (!Button[id]) return
        if (Button[id].image) {
            document.getElementById('image').src = Button[id].image;
            document.getElementById('imageHover').style.display = 'block';
        }
    }
    else {
        document.getElementById('imageHover').style.display = 'none';
    }
})
