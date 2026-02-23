function validateString(string, regExp) {
    if (string.length === 0) return false;
    const re = regExp;
    return re.test(string);
}

function validateEmail(email) {
    return validateString(email, /^\w+([.-]?\w+)@\w+([.-]?\w+)(.\w)$/);
}

function validateName(name) {
    return validateString(name, /^(?:[a-zA-Z0-9_]|[а-яёА-ЯЁ0-9_])$/); // length 3-24
}

function validateUsername(username) {
    return validateString(username, /^[0-9A-Za-z_]$/); // length 3-16
}

function changeColor(obj, property, color) {
    obj[property] = color;
}
