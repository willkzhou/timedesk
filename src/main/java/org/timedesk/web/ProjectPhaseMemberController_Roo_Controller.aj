// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.web;

import java.io.UnsupportedEncodingException;
import java.lang.Long;
import java.lang.String;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import org.joda.time.format.DateTimeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;
import org.timedesk.entity.ProjectMember;
import org.timedesk.entity.ProjectPhase;
import org.timedesk.entity.ProjectPhaseMember;

privileged aspect ProjectPhaseMemberController_Roo_Controller {
    
    @Autowired
    private GenericConversionService ProjectPhaseMemberController.conversionService;
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String ProjectPhaseMemberController.createForm(Model model) {
        model.addAttribute("projectPhaseMember", new ProjectPhaseMember());
        addDateTimeFormatPatterns(model);
        List dependencies = new ArrayList();
        if (ProjectPhase.countProjectPhases() == 0) {
            dependencies.add(new String[]{"projectPhase", "projectphases"});
        }
        model.addAttribute("dependencies", dependencies);
        return "projectphasemembers/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String ProjectPhaseMemberController.show(@PathVariable("id") Long id, Model model) {
        addDateTimeFormatPatterns(model);
        model.addAttribute("projectphasemember", ProjectPhaseMember.findProjectPhaseMember(id));
        model.addAttribute("itemId", id);
        return "projectphasemembers/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String ProjectPhaseMemberController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("projectphasemembers", ProjectPhaseMember.findProjectPhaseMemberEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) ProjectPhaseMember.countProjectPhaseMembers() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("projectphasemembers", ProjectPhaseMember.findAllProjectPhaseMembers());
        }
        addDateTimeFormatPatterns(model);
        return "projectphasemembers/list";
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String ProjectPhaseMemberController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("projectPhaseMember", ProjectPhaseMember.findProjectPhaseMember(id));
        addDateTimeFormatPatterns(model);
        return "projectphasemembers/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String ProjectPhaseMemberController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        ProjectPhaseMember.findProjectPhaseMember(id).remove();
        model.addAttribute("page", (page == null) ? "1" : page.toString());
        model.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/projectphasemembers?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    @ModelAttribute("projectmembers")
    public Collection<ProjectMember> ProjectPhaseMemberController.populateProjectMembers() {
        return ProjectMember.findAllProjectMembers();
    }
    
    @ModelAttribute("projectphases")
    public Collection<ProjectPhase> ProjectPhaseMemberController.populateProjectPhases() {
        return ProjectPhase.findAllProjectPhases();
    }
    
    Converter<ProjectMember, String> ProjectPhaseMemberController.getProjectMemberConverter() {
        return new Converter<ProjectMember, String>() {
            public String convert(ProjectMember projectMember) {
                return new StringBuilder().append(projectMember.getMemberId()).toString();
            }
        };
    }
    
    Converter<ProjectPhase, String> ProjectPhaseMemberController.getProjectPhaseConverter() {
        return new Converter<ProjectPhase, String>() {
            public String convert(ProjectPhase projectPhase) {
                return new StringBuilder().append(projectPhase.getPhaseId()).append(" ").append(projectPhase.getDescription()).append(" ").append(projectPhase.getStartDate()).toString();
            }
        };
    }
    
    Converter<ProjectPhaseMember, String> ProjectPhaseMemberController.getProjectPhaseMemberConverter() {
        return new Converter<ProjectPhaseMember, String>() {
            public String convert(ProjectPhaseMember projectPhaseMember) {
                return new StringBuilder().append(projectPhaseMember.getPhaseMemberId()).append(" ").append(projectPhaseMember.getStartDate()).append(" ").append(projectPhaseMember.getEndDate()).toString();
            }
        };
    }
    
    @PostConstruct
    void ProjectPhaseMemberController.registerConverters() {
        conversionService.addConverter(getProjectMemberConverter());
        conversionService.addConverter(getProjectPhaseConverter());
        conversionService.addConverter(getProjectPhaseMemberConverter());
    }
    
    void ProjectPhaseMemberController.addDateTimeFormatPatterns(Model model) {
        model.addAttribute("projectPhaseMember_startdate_date_format", DateTimeFormat.patternForStyle("S-", LocaleContextHolder.getLocale()));
        model.addAttribute("projectPhaseMember_enddate_date_format", DateTimeFormat.patternForStyle("S-", LocaleContextHolder.getLocale()));
    }
    
    private String ProjectPhaseMemberController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
        String enc = request.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        }
        catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
