function copyToClipboard() {
    var copyText = document.getElementById("calendar_link")
    copyText.select()
    copyText.setSelectionRange(0, 99999)
    navigator.clipboard.writeText(copyText.value)
    alert("Kalendoriaus URL nukopijuotas")
}


function generateCalendarUrl() {

    let checkedCount = 0
    let notCheckedCount = 0

    let new_url = new URL(url)

    bureliaiInputs.forEach(input => {
        if (input.checked) {
            new_url.searchParams.append('id', input.value)
            checkedCount++
        }
        else { notCheckedCount++ }
    })

    if (checkedCount > 0) {
        if (notCheckedCount == 0) { selectAll() }
        else { calendarLinkTextBox.value = new_url }
    }
    else { calendarLinkTextBox.value = null }
}

function selectAll() {
    bureliaiInputs.forEach(input => { input.checked = true })
    let new_url = new URL(url)
    new_url.searchParams.append('all', true)
    calendarLinkTextBox.value = new_url
}

function deselectAll() {
    bureliaiInputs.forEach(input => { input.checked = false })
    calendarLinkTextBox.value = null

}

const bureliaiInputs = document.querySelector(".bureliai").querySelectorAll("input[type=checkbox]")
const url = new URL(window.location.protocol + window.location.hostname + window.location.pathname + "api")
const calendarLinkTextBox = document.querySelector("#calendar_link")

bureliaiInputs.forEach(input => { input.addEventListener('click', generateCalendarUrl) })