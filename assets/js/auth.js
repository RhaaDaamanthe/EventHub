// La fonction doit être accessible (dans un fichier .js lié ou dans le bloc javascripts)
function togglePasswordVisibility(fieldId) {
    const passwordField = document.getElementById(fieldId);
    // Trouve l'icône en cherchant dans l'élément parent qui a la classe 'form-group-with-icon'
    const toggleIcon = passwordField.closest('.form-group-with-icon').querySelector('.password-toggle i');

    if (passwordField.type === 'password') {
        passwordField.type = 'text';
        toggleIcon.classList.remove('fa-eye-slash');
        toggleIcon.classList.add('fa-eye');
    } else {
        passwordField.type = 'password';
        toggleIcon.classList.remove('fa-eye');
        toggleIcon.classList.add('fa-eye-slash');
    }
}