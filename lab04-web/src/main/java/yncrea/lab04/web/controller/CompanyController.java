package yncrea.lab04.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import yncrea.lab04.core.entity.Company;
import yncrea.lab04.core.service.CompanyService;

import java.util.List;

@Controller
public class CompanyController {
    @Autowired
    private CompanyService companyService;

    private static final Logger LOGGER = LoggerFactory.getLogger(CompanyController.class);


//    public CompanyController(CompanyService companyService) {
//        this.companyService = companyService;
//    }

//    @RequestMapping(path = "/")
//    public String welcomePage() {
//        return "welcome";
//    }

    @RequestMapping(path = "/list")
    public String getListOfCompanies(ModelMap modelMap) {
        final List<Company> companies = companyService.findAllWithProjects();
        modelMap.addAttribute("companies", companies);
        LOGGER.debug("Get all companies");
        LOGGER.info("Displaying all companies");
        return "companiesList";
    }

    @RequestMapping(path = "/form",method = RequestMethod.GET)
    public String getForm(ModelMap modelMap) {
        Company company = new Company();
        modelMap.addAttribute(company);
        return "companyForm";
    }

    @RequestMapping(path = "/form",method = RequestMethod.POST)
    public String submitForm(@ModelAttribute("company") Company company) {
        companyService.save(company);
        LOGGER.info("Company created successfully");
        return "redirect:list";
    }

    @RequestMapping(path = "{id}/delete",method = RequestMethod.GET)
    public String deleteCompany(@PathVariable Long id) {
        LOGGER.warn("Caution : Please add a null check");
        companyService.deleteById(id);
        LOGGER.info("Company deleted");
        return "redirect:/list";
    }
}
