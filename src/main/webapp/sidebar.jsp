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
            <li class="sidebar-item">
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
            <li class="sidebar-item">
                <a class="sidebar-link" href="admins.jsp">
                    <i class="align-middle" data-feather="user"></i>
                    <span class="align-middle">Admins</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a data-bs-target="#tickets-submenu" data-bs-toggle="collapse" class="sidebar-link collapsed">
                    <i class="align-middle" data-feather="log-in"></i>
                    <span class="align-middle">Tickets</span>
                </a>
                <ul id="tickets-submenu" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                    <li class="sidebar-item">
                        <a class="sidebar-link" href="AddTicketGroup.jsp">
                            <i class="align-middle" data-feather="plus-square"></i>
                            <span class="align-middle">New Ticket</span>
                        </a>
                    </li>
                    <li class="sidebar-item">
                        <a class="sidebar-link" href="list_tickets.jsp">
                            <i class="align-middle" data-feather="file-text"></i>
                            <span class="align-middle">List Tickets</span>
                        </a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const sidebarLinks = document.querySelectorAll('.sidebar-link');
        const currentUrl = window.location.href;
        const userRole = getCookie('role');

        function getCookie(name) {
            const value = `; ${document.cookie}`;
            const parts = value.split(`; ${name}=`);
            if (parts.length === 2) return parts.pop().split(';').shift();
        }

        const allSidebarItems = document.querySelectorAll('.sidebar-item');
        allSidebarItems.forEach(item => item.style.display = 'none');

        if (userRole === 'superadmin') {
            allSidebarItems.forEach(item => item.style.display = 'block');
        } else if (userRole === 'admin' || userRole ==='Admin') {
            document.querySelector('.sidebar-link[href="employee.jsp"]').parentElement.style.display = 'block';
            document.querySelector('.sidebar-link[href="task.jsp"]').parentElement.style.display = 'block';
            document.querySelector('.sidebar-link[href="profile.jsp"]').parentElement.style.display = 'block';
            document.querySelector('.sidebar-link[data-bs-target="#tickets-submenu"]').parentElement.style.display = 'block';
        } else {
            document.querySelector('.sidebar-link[href="admin.jsp"]').parentElement.style.display = 'block';
            document.querySelector('.sidebar-link[href="task.jsp"]').parentElement.style.display = 'block';
            document.querySelector('.sidebar-link[href="profile.jsp"]').parentElement.style.display = 'block';
        }

        sidebarLinks.forEach(link => {
            if (link.href === currentUrl) {
                link.parentElement.classList.add('active');
            }
        });
    });
</script>
