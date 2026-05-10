<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>CondoDesk | Auditoria</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        :root { --purple: #7C3AED; --dark: #0F0A1F; --glass: rgba(255,255,255,0.03); --border: rgba(255,255,255,0.08); --muted: #94A3B8; }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: var(--dark); color: #F8FAFC; font-family: 'Space Grotesk', sans-serif; display: flex; min-height: 100vh; background-image: radial-gradient(circle at top right, #1A1035 0%, #0F0A1F 100%); }
        .sidebar { width: 240px; background: rgba(0,0,0,0.4); border-right: 1px solid var(--border); padding: 30px 20px; display: flex; flex-direction: column; }
        .brand { font-size: 1.3rem; font-weight: 700; margin-bottom: 40px; text-align: center; background: linear-gradient(to right, #FFF, var(--purple)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .nav-link { display: block; padding: 12px 16px; color: var(--muted); text-decoration: none; border-radius: 10px; margin-bottom: 8px; font-size: 0.9rem; }
        .nav-link:hover { background: var(--glass); color: #FFF; }
        .nav-link.active { border-left: 3px solid var(--purple); color: #FFF; }
        .main { flex: 1; padding: 40px 50px; overflow-y: auto; }
        h1 { background: linear-gradient(to right, #FFF, var(--purple)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-size: 1.8rem; margin-bottom: 30px; }
        .card { background: var(--glass); border: 1px solid var(--border); border-radius: 20px; padding: 25px; }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; color: var(--muted); font-size: 0.75rem; text-transform: uppercase; padding: 12px 15px; border-bottom: 1px solid var(--border); }
        td { padding: 14px 15px; font-size: 0.85rem; border-bottom: 1px solid rgba(255,255,255,0.02); vertical-align: middle; }
        .acao-badge { display: inline-block; padding: 4px 10px; border-radius: 8px; font-size: 0.75rem; font-weight: 600; }
        .acao-ABERTURA { background: rgba(59,130,246,0.2); color: #93C5FD; border: 1px solid #3B82F6; }
        .acao-MUDANCA_STATUS { background: rgba(251,191,36,0.2); color: #FDE68A; border: 1px solid #F59E0B; }
        .acao-COMENTARIO { background: rgba(124,58,237,0.2); color: #A78BFA; border: 1px solid var(--purple); }
        .acao-LOGIN { background: rgba(16,185,129,0.2); color: #6EE7B7; border: 1px solid #10B981; }
        .empty { text-align: center; color: var(--muted); padding: 40px; }
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="brand">CondoDesk AI</div>
    <a href="/dashboard" class="nav-link">📊 Dashboard</a>
    <a href="/admin/blocos/novo" class="nav-link">🏢 Estruturas</a>
    <a href="/admin/usuarios/novo" class="nav-link">👥 Usuários</a>
    <a href="/admin/vinculos/novo" class="nav-link">🔗 Mapeamento</a>
    <a href="/admin/tipos-chamado" class="nav-link">🏷️ Tipos de Chamado</a>
    <a href="/admin/status" class="nav-link">🔄 Status</a>
    <a href="/chamados" class="nav-link">📋 Chamados</a>
    <a href="/admin/auditoria" class="nav-link active">🔍 Auditoria</a>
    <a href="/logout" class="nav-link" style="color:#F87171; margin-top:40px;">🚪 Sair</a>
</aside>

<main class="main">
    <h1>🔍 Log de Auditoria</h1>
    <div class="card">
        <table>
            <thead>
                <tr>
                    <th>Data/Hora</th>
                    <th>Usuário</th>
                    <th>Ação</th>
                    <th>Entidade</th>
                    <th>Detalhes</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${registros}">
                    <tr>
                        <td style="color:var(--muted); font-size:0.8rem;">${r.dataHora}</td>
                        <td style="font-weight:600;">${r.usuario.nome}<br><span style="color:var(--muted); font-size:0.75rem;">${r.usuario.tipo}</span></td>
                        <td><span class="acao-badge acao-${r.acao}">${r.acao}</span></td>
                        <td style="color:var(--purple);">${r.entidade}</td>
                        <td style="color:#CBD5E1;">${r.detalhes}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty registros}">
                    <tr><td colspan="5" class="empty">Nenhuma ação registrada ainda.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>