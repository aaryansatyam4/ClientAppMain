<nav id="sidebar" class="sidebar js-sidebar">
    <div class="sidebar-content js-simplebar">
        <a class="sidebar-brand" href="#">
            <span class="align-middle">NIC</span>
        </a>

        <ul class="sidebar-nav">
            <li class="sidebar-item">
                <a class="sidebar-link" href="admin.jsp">
                    <i class="align-middle" data-feather="sliders"></i>
                    <span class="align-middle">Dashboard</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="employee.jsp">
                    <i class="align-middle" data-feather="user"></i>
                    <span class="align-middle">Employees</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="#">
                    <i class="align-middle" data-feather="log-in"></i>
                    <span class="align-middle">Departments</span>
                </a>
            </li>
            <li class="sidebar-item nav-link nav-link-collapse">
                <a class="sidebar-link" href="task.jsp">
                    <i class="align-middle" data-feather="user-plus"></i>
                    <span class="align-middle">Tasks</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="profile.jsp">
                    <i class="align-middle" data-feather="grid"></i>
                    <span class="align-middle">Profile</span>
                </a>
            </li>
            <li class="sidebar-item dropdown">
                <a class="sidebar-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
                    <i class="align-middle" data-feather="user"></i>
                    <span class="align-middle">Admins</span>
                </a>
                <ul class="dropdown-menu">
                    <li>
                        <a class="dropdown-item" href="profile.jsp">
                            <i class="align-middle" data-feather="grid"></i>
                            <span class="align-middle">Profile</span>
                        </a>
                    </li>
                </ul>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="newTask.jsp">
                    <i class="align-middle" data-feather="log-in"></i>
                    <span class="align-middle">New Tickets</span>
                </a>
            </li>
        </ul>
    </div>
</nav>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const sidebarLinks = document.querySelectorAll('.sidebar-link');
        const currentUrl = window.location.href;

        fetch('http://localhost:8080/v1/api/login/user/role', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include'
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                const userRole = data.role;

                // Hide all sidebar items initially
                const allSidebarItems = document.querySelectorAll('.sidebar-item');
                allSidebarItems.forEach(item => item.style.display = 'none');

                // Show items based on user role
                if (userRole === 'super_admin') {
                    allSidebarItems.forEach(item => item.style.display = 'block');
                } else if (userRole === 'admin' || userRole === 'Admin') {
                    document.querySelector('.sidebar-link[href="admin.jsp"]').parentElement.style.display = 'block';
                    document.querySelector('.sidebar-link[href="employee.jsp"]').parentElement.style.display = 'block';
                    document.querySelector('.sidebar-link[href="task.jsp"]').parentElement.style.display = 'block';
                    document.querySelector('.sidebar-link[href="profile.jsp"]').parentElement.style.display = 'block';
                    document.querySelector('.sidebar-link[href="newTask.jsp"]').parentElement.style.display = 'block';
                } else {
                    // Handle other roles or defaults here
                    document.querySelector('.sidebar-link[href="admin.jsp"]').parentElement.style.display = 'block';
                    document.querySelector('.sidebar-link[href="task.jsp"]').parentElement.style.display = 'block';
                    document.querySelector('.sidebar-link[href="#"]').parentElement.style.display = 'block';
                    document.querySelector('.sidebar-link[href="profile.jsp"]').parentElement.style.display = 'block';
                }

                // Activate current link in sidebar
                sidebarLinks.forEach(link => {
                    if (link.href === currentUrl) {
                        link.parentElement.classList.add('active');
                    }
                });
            } else {
                console.error('Failed to fetch user role:', data.message);
            }
        })
        .catch(error => console.error('Error fetching user role:', error));
    });
</script>
