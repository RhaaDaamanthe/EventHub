// Click afficher mdp
function togglePasswordVisibility() {
            const passwordField = document.querySelector('.password-input');
            const toggleIcon = document.querySelector('.password-toggle i');

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