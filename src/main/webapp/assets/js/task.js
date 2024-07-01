$(document).ready(function () {
    var table = $('#task-table').DataTable({
        ajax: {
            url: 'fetchTasks',
            dataSrc: ''
        },
        columns: [
            { data: 'id' },
            { data: 'ticketDescription' },
            { data: 'severity' },
            { data: 'assignee' },
            { data: 'createdAt' },
            { data: 'status' },
            { data: 'remark' },
			
			
            {
                data: null,
                render: function (data, type, row) {
                    return '<button class="viewTicket" data-task-id="' + data.id + '">View Ticket</button>';
                }
            }
        ]
    });

    var modal = document.getElementById("ticketModal");
    var span = document.getElementsByClassName("close")[0];

    $(document).on("click", ".viewTicket", function () {
        var taskId = $(this).data("task-id");
        $.ajax({
            url: 'fetchTaskDetails',
            method: 'GET',
            data: { taskId: taskId },
            success: function (response) {
                $("#ticketId").text(response.id);
                $("#ticketName").text(response.ticketName);
                $("#ticketDescription").text(response.ticketDescription);
                $("#ticketSeverity").text(response.severity);
                $("#ticketRemarks").text(response.remark);
                $("#ticketAssignee").text(response.assignee);
                $("#ticketCreatedAt").text(response.createdAt);
                $("#ticketDueDate").text(response.dueDate);
                $("#ticketCompletedAt").text(response.completedAt);
                $("#ticketStatus").text(response.status);
                $("#ticketCreatedBy").text(response.createdBy);
                $("#ticketUpdatedBy").text(response.updatedBy);
                $("#ticketUpdatedAt").text(response.updatedAt);
                $("#ticketManager").text(response.manager);

                modal.style.display = "block";
            },
            error: function (xhr, status, error) {
                console.error("Error fetching task details:", error);
            }
        });
    });

    span.onclick = function () {
        modal.style.display = "none";
    }

    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
});
