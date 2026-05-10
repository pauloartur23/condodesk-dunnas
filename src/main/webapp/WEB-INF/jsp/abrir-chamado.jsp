<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>CondoDesk | Novo Chamado</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        :root { --purple: #7C3AED; --dark: #0F0A1F; }
        body { background: var(--dark); color: #F8FAFC; font-family: 'Space Grotesk', sans-serif; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; background-image: radial-gradient(circle at 80% 20%, #1A1035 0%, #0F0A1F 100%); }
        .glass-panel { background: rgba(255,255,255,0.03); backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,0.1); border-radius: 28px; padding: 45px; width: 520px; }
        h2 { background: linear-gradient(to right, #FFF, var(--purple)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; text-align: center; margin-bottom: 30px; }
        label { display: block; color: #94A3B8; font-size: 0.7rem; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 8px; }
        input, select, textarea { width: 100%; padding: 14px; margin-bottom: 20px; background: rgba(0,0,0,0.4); border: 1px solid rgba(255,255,255,0.1); border-radius: 12px; color: white; font-family: inherit; box-sizing: border-box; }
        select option { background: #1A1035; }
        textarea { height: 100px; resize: none; }
        input:focus, select:focus, textarea:focus { border-color: var(--purple); outline: none; }
        .btn-submit { width: 100%; padding: 16px; background: var(--purple); border: none; border-radius: 12px; color: white; font-weight: 700; cursor: pointer; font-size: 1rem; }
        .btn-submit:hover { opacity: 0.85; }
        .voltar { display: block; text-align: center; margin-top: 15px; color: #94A3B8; text-decoration: none; font-size: 0.85rem; }
        .voltar:hover { color: white; }
        .sla-hint { font-size: 0.75rem; color: #94A3B8; margin-top: -14px; margin-bottom: 16px; }
        .alert-erro { background: rgba(239,68,68,0.1); border: 1px solid rgba(239,68,68,0.3); border-radius: 10px; padding: 12px 16px; color: #FCA5A5; font-size: 0.85rem; margin-bottom: 15px; }
    </style>
</head>
<body>
<div class="glass-panel">
    <h2>Abrir Novo Chamado</h2>

    <c:if test="${param.erro == 'sem_permissao'}">
        <div class="alert-erro">Você não tem permissão para abrir chamado nesta unidade.</div>
    </c:if>

    <form action="/chamados/salvar" method="post">
        <label>Título do Chamado</label>
        <input type="text" name="titulo" placeholder="Ex: Vazamento no Banheiro" required>

        <label>Unidade</label>
        <select name="unidadeId" required>
            <option value="">Selecione a unidade...</option>
            <c:forEach items="${unidades}" var="u">
                <option value="${u.id}">Bloco ${u.bloco.identificacao} - Apto ${u.numero} (${u.andar}º andar)</option>
            </c:forEach>
        </select>

        <!-- CORRIGIDO: Tipos de chamado vêm do banco com SLA exibido -->
        <label>Tipo do Chamado</label>
        <select name="tipoChamadoId" required id="tipoChamadoSelect" onchange="atualizarSla(this)">
            <option value="">Selecione o tipo...</option>
            <c:forEach items="${tiposChamado}" var="t">
                <option value="${t.id}" data-sla="${t.slaHoras}">${t.titulo} (SLA: ${t.slaHoras}h)</option>
            </c:forEach>
        </select>
        <p class="sla-hint" id="slaHint"></p>

        <label>Descrição Detalhada</label>
        <textarea name="descricao" placeholder="Descreva o problema detalhadamente..." required></textarea>

        <button type="submit" class="btn-submit">ENVIAR CHAMADO</button>
    </form>
    <a href="javascript:history.back()" class="voltar">← Voltar</a>
</div>
<script>
    function atualizarSla(sel) {
        var hint = document.getElementById('slaHint');
        var opt = sel.options[sel.selectedIndex];
        var sla = opt ? opt.getAttribute('data-sla') : '';
        hint.textContent = sla ? 'Prazo de atendimento: até ' + sla + ' horas.' : '';
    }
</script>
</body>
</html>
